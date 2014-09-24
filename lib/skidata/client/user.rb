module Skidata
  class Client
    # Defines methods related to users
    module User
      # Returns the login type of the user based on username provided.
      def get_user(id, validation_cookie, *args)
        response = get("/DesktopModules/v1/API/user/#{id}", {:validation_cookie => validation_cookie})

        response
      end
    end
  end
end
