# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  private
  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      UserMailer.welcome_email(resource).deliver_now
      render json: {
        message: "Signed up sucessfully.",
        data: resource
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        status: { code: 200, message: "Account deleted successfully."}
      }, status: :ok
    else
      render json: {
        status: {code: 422, message: "User couldn't be created successfully"},
        errors: resource.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end
end