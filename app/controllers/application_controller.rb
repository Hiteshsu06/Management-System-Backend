class ApplicationController < ActionController::API
    include ActionController::MimeResponds

    private

    def authorize_role(*required_role)
      if !required_role.include?(current_user[:role])
        render json: { error: "Access denied: You do not have the required permissions" }, status: :forbidden
      end
    end
end