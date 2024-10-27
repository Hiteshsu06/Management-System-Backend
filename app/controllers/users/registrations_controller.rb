# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  
  def update
    # Load the current user
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    # Update the resource with the account_update_params
    if resource.update(account_update_params)
      render json: {
        message: "Account updated successfully.",
        data: resource
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "Account couldn't be updated." },
        errors: resource.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  private

  def account_update_params
    # Specify which parameters are allowed for update
    params.permit(:full_address, :first_name, :last_name, :email, :role, :gender, :password, :profile_image)
  end

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