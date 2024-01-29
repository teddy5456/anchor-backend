class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create, :options]
  helper_method :set_current_user  # Add this line

  def create
    identifier = params[:identifier]
    password = params[:password]
  
    user = User.find_by(employee_id: identifier) || User.find_by(username: identifier)
  
    if user&.authenticate(params[:password])
      # Log in successful
      token = generate_token(user)
      set_current_user(user)  # Call the helper method to set the current user
      render json: { status: 'success', message: 'Logged in successfully', token: token, user: user }
    else
      # Log in failed
      render json: { status: 'error', message: 'Invalid email/username or password' }
    end
  end

  def current_user
    if @current_user
      render json: { id: @current_user.id, name: @current_user.name }
    else
      head :no_content
    end
  end

  def set_current_user(user)
    # Implement the logic to set the current user in your session or wherever needed.
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
    render json: { status: 'success', message: 'Logged out successfully' }
  end

  def options
    head :ok
  end

  def generate_token(user)
    expiration_time = 1.hour.from_now.to_i
    payload = {
      user_id: user.id,
      exp: expiration_time
    }

    # Generate the token with a secret key
    secret_key = Rails.application.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end
end
