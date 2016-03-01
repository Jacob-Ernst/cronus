class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  # [POST] /users
  def create
    user = User.new user_params

    user.password = params[:password]

    if user.save
      authenticate
    else
      render json: { error: 'Could not create new resource' }, status: 409
    end

  end

  # PUT/PATCH /users
  def update
    @current_user.assign_attributes(user_params)
    if @current_user.save
      render json: { message: 'Succesfully updated user' }
    else
      render json: { error: 'Unable to update user' }, status: 422
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(:first_name,
            :last_name,
            :email
          )
  end

end
