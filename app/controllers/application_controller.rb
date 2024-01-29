class ApplicationController < ActionController::Base
  
  before_action :require_login, except: [:current_user]

  def current_user
    @current_user ||= decode_jwt_token
  end
  helper_method :current_user

  def require_login
    return if request.method == 'OPTIONS'  # Allow OPTIONS requests without login
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  private

  def decode_jwt_token
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256').first
    decoded_token['user_id']
  rescue JWT::DecodeError
    nil
  end
end
