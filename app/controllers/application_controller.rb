class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  private
  def current_user
    @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id] && cookies[:user_id] != ""
    @current_user ||= User.find(cookies.permanent[:user_id]) if cookies.permanent[:user_id] && cookies[:user_id] != ""
    return @current_user
  end
  
  def logged_in?
    if !current_user
      redirect_to login_path
    end
  end

  # def not_found
    # raise ActionController::RoutingError.new('Not Found')
  # end
end
