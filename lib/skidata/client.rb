module Skidata
    # Wrapper for the Skidata REST API
    class Client < API
        Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

        include Skidata::Client::Authentication
        include Skidata::Client::User
        include Skidata::Client::Points
        include Skidata::Client::PointActivities
        # include Skidata::Client::Locations
        # include Skidata::Client::Geographies
        # include Skidata::Client::Tags
        # include Skidata::Client::Comments
        # include Skidata::Client::Likes
        # include Skidata::Client::Subscriptions
        # include Skidata::Client::Embedding

        def get_authorization_cookie admin_email, password
            login_type = get_login_type admin_email
            validation_response = validate admin_email, login_type, password

            headers = validation_response.headers

            validation_response = ActiveSupport::JSON.decode validation_response.body

            if validation_response.has_key?("userIsVerified") && validation_response['userIsVerified']
                set_cookie_value = headers['Set-Cookie']

                parsed_cookie_values = CGI::Cookie::parse(set_cookie_value)

                parsed_cookie_values[ENV['SKIDATA_API_AUTH_COOKIE_KEY'] || '.DOTNETNUKE']
            else
                nil
            end
        end
    end
end
