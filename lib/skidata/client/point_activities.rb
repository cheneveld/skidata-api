module Skidata
  class Client
    # Defines methods related to point activities
    module PointActivities
      # Returns the points records for a particular user
      def get_point_activities(validation_cookie, *args)
        response = get("/DesktopModules/v1/API/pointActivities", {:validation_cookie => validation_cookie})
        
        #ActiveSupport::JSON.decode response.body
        response
      end

      def get_point_activities_for_user(id, validation_cookie, *args)
        response = get("/DesktopModules/v1/API/pointActivities/#{id}", {:validation_cookie => validation_cookie})
        
        ActiveSupport::JSON.decode response.body
      end
    end
  end
end
