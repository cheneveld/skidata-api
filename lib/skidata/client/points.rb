module Skidata
  class Client
    # Defines methods related to points
    module Points
      # Returns the points records for a particular user
      def get_points(user_id, validation_cookie, *args)
        response = get("/DesktopModules/v1/API/points/#{user_id}", {:validation_cookie => validation_cookie})
        
        ActiveSupport::JSON.decode response.body
      end

      # Returns the points records for a particular user
      def add_point(user_id, activity_id, awarded_by, validation_cookie, *args)
        response = post("/DesktopModules/v1/API/points", {:userId => user_id, :activityId => activity_id, :awardedBy => awarded_by, :validation_cookie => validation_cookie})
        
        response
      end
    end
  end
end
