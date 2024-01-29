class UsersController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create, :index, :current_user]
  before_action :require_login, only: [:index, :current_user]  # Modify this line

  

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    puts "Params ID: #{params[:id]}" # Add this line for debugging
    @user = User.find(params[:id])
  
    respond_to do |format|
      format.json { render json: @user }
    end
  end
  

  def current_user
    user_data = decode_token(cookies.signed[:auth_token])

    if user_data
      render json: { status: 'success', user: current_user_data(user_data) }
    else
      render json: { status: 'error', message: 'Invalid or expired token' }
    end
  end

  private

  def set_current_user
    # Logic to set current user based on the decoded token
    # For example, you might want to use the decoded_token from cookies
    user_data = decode_token(cookies.signed[:auth_token])
    @current_user = User.find(user_data['user_id']) if user_data
  end

  def decode_token(token)
    return nil unless token

    begin
      secret_key = Rails.application.secret_key_base
      decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')[0]
      # Return the entire decoded_token for use in the current_user action
      decoded_token
    rescue JWT::DecodeError
      nil # Handle invalid or expired token
    end
  end


  def user_params
    permitted_params = params.permit(:name, :password, :username, :employee_id, :password_confirmation, :role)

    if params[:user].present?
      permitted_params = permitted_params.merge(params.require(:user).permit(:name, :username, :employee_id, :role, :password, :password_confirmation))
    end

    permitted_params
  end

  def current_user_data
    {
      id: @current_user.id,
      name: @current_user.name,
      username: @current_user.username,
      # Add other user attributes as needed
    }
  end
end
