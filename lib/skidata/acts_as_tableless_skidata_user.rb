module Skidata
  module ActsAsTablelessSkidataUser
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_tableless_skidata_user(options = {})
        include Skidata::ActsAsTablelessSkidataUser::LocalInstanceMethods
      end

      def load_from_api id, validation_cookie
        client = Skidata.client

        api_user_response = client.get_user id, validation_cookie

        if api_user_response.code.to_i == 200
          user_hash = ActiveSupport::JSON.decode api_user_response.body

          id = user_hash['UserID']
          user_name = user_hash['Username']      
          email = user_hash['EmailAddress']          
          name = user_hash['DisplayName']
          overall_position = user_hash['LeaderboardPosition']['OverallPosition'] rescue "-"
          season_position = user_hash['LeaderboardPosition']['SeasonPosition'] rescue "-"
          weekly_position = user_hash['LeaderboardPosition']['WeeklyPosition'] rescue "-"
          season_points = user_hash['CurrentPoints']['SeasonPointsEarned'] rescue "-"
          points_remaining = user_hash['CurrentPoints']['PointsRemaining'] rescue "-"
          roles = user_hash['Roles'].map{|r| r["Name"]}

          cookies = client.get_set_cookies_from_response(api_user_response)

          avatar = ENV['SKIDATA_API_ENDPOINT'].freeze + user_hash['Avatar'] rescue nil
          
          record = new(:id => id,
                       :email => email,
                       :user_name => user_name,
                       :name => name,
                       :leaderboard_overall_position => overall_position,
                       :leaderboard_season_position => season_position,
                       :leaderboard_weekly_position => weekly_position,
                       :season_points_earned => season_points,
                       :points_remaining => points_remaining,
                       :roles => roles,
                       :avatar => avatar,
                       :cookies => cookies)

          record.set_points validation_cookie

          return record
        else
          raise ActiveRecord::RecordNotFound
        end

      end
    end

    module LocalInstanceMethods
      def authenticate_user
        # don't need to run true api validation if something else is wrong
        return unless self.errors.empty?

        client = Skidata.client

        begin 
          login_type = client.get_login_type self.email
          
          validation_response = client.validate self.email, login_type, self.password

          parsed_validation_response = ActiveSupport::JSON.decode validation_response.body

          if parsed_validation_response.has_key?("userIsVerified") && parsed_validation_response['userIsVerified']
            self.id = parsed_validation_response['userId']
            self.cookies = client.get_set_cookies_from_response(validation_response)
          else
            if(parsed_validation_response.has_key?("Message"))
              errors.add(:'error:', parsed_validation_response['Message'])
            else
              errors.add(:'error:', "Invalid username or password.")
            end
          end
        rescue
          errors.add(:'error:', "Something went wrong, please try again.")
        end
      end

      def set_points validation_cookie
        self.points = Skidata.client.get_points self.id, validation_cookie
      end
    end
  end
end

ActiveRecord::Base.send :include, Skidata::ActsAsTablelessSkidataUser
