module Skidata
    # Wrapper for the Skidata REST API
    class Client < API
        Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

        include Skidata::Client::Authentication
        include Skidata::Client::User
        include Skidata::Client::Points
        include Skidata::Client::PointActivities

        def get_authorization_cookie admin_email, password
            login_type = get_login_type admin_email
            validation_response = validate admin_email, login_type, password

            validation_response = ActiveSupport::JSON.decode validation_response.body

            if validation_response.has_key?("userIsVerified") && validation_response['userIsVerified']
                get_cookie_value_from_response validation_response
            else
                nil
            end
        end

        def get_set_cookies_from_response validation_response
            headers = validation_response.headers

            headers['Set-Cookie']
        end

        def get_cookie_value_from_response validation_response
            set_cookie_value = get_set_cookies_from_response validation_response

            parsed_cookie_values = CGI::Cookie::parse(set_cookie_value)

            parsed_cookie_values[ENV['SKIDATA_API_AUTH_COOKIE_KEY'] || '.DOTNETNUKE']
        end

        def get_verification_token_value_from_response validation_response
            set_cookie_value = get_set_cookies_from_response validation_response

            parsed_cookie_values = CGI::Cookie::parse(set_cookie_value)

            parsed_cookie_values["__RequestVerificationToken"]
        end

        
    end
end
