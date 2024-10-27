class UserCredentialsController < ApplicationController
    def show
        @user = User.find(params[:id])
        if @user
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
end