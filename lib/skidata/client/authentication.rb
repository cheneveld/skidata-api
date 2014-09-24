module Skidata
  class Client
    # Defines methods related to authentication
    module Authentication
      # Returns the login type of the user based on username provided.
      def get_login_type(username, *args)
        response = get("/DesktopModules/v1/API/Authentication/GetLoginType/#{username}")
        
        #puts response.body, response.code, response.message

        return response.body if response.code.to_i == 200

        # defauly to 0, validate will fail with this code
        return "0"
      end

      # Returns the LRS internal login credential for the user provided, if the specified login credentials pass validation, else returns error message
      # {
      #   "credential": "password"
      # }
      #
      def validate(username, loginType, password, options={})
        credential = {:credential => password}
        response = post("/DesktopModules/v1/API/Authentication/Validate/#{username}/#{loginType}", options.merge(credential))

        response
      end

      # Triggers the password reset process for the user with the specified user name
      # Returns Http response code 200 if e-mail sent, 400 otherwise.
      #
      def reset_password(username, options={})
        response = post("/DesktopModules/v1/API/Authentication/ResetPassword/#{username}", options)
        response
      end
    end
  end
end
