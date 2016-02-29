class AuthController < ActionController::Base
  def authenticate
    user = User.find_by_email(params[:email]) # you'll need to implement this
    if user.try :authenticate, params[:password]
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid email or password' }, status: 422
    end
  end
end
