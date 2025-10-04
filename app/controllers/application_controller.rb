class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  
  before_action :require_authentication
  
  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
    
    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?
    
    def require_authentication
      unless user_signed_in?
        redirect_to login_path, alert: "You must be logged in to access this page"
      end
    end
end
