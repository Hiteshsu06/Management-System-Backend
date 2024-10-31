class UserCredentialsController < ApplicationController
    before_action :authenticate_user!
    def filter
      @users = User.where.not(id: current_user.id).where("email ILIKE ?", "%#{params[:search]}%")
      if @users
        render json: @users
      else
        render json: { errors: @users.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      user = User.find_by(id: params[:id])
      if user.destroy
        head :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update_role
      user = User.find(params[:id])
      if user.update(role: params[:role])
        render json: { data: user, message: 'User role has been successfully updated' }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
        @user = User.find(params[:id])
        if @user
          render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update_user
      user = User.find(params[:id])
      if user.update(user_params)
        render json: { data: user, message: 'User has been successfully updated'}
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:first_name, :last_name, :full_address, :gender, :profile_image)
    end
end