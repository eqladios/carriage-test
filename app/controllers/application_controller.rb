class ApplicationController < ActionController::API
    def json_response(object, status = :ok)
        render json: object, status: status
    end

    def render_resource(resource)
        if resource.errors.empty?
          render json: resource
        else
          validation_error(resource)
        end
    end
    
      def validation_error(resource)
        render json: {
            errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors,
                code: '100'
            }
            ]
        }, status: :bad_request
    end
    
    include CanCan::ControllerAdditions
    rescue_from CanCan::AccessDenied do |exception|
        render json: {}, status: 401, message: "Access Denied"
    end
end
