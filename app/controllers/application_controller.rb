class ApplicationController < ActionController::Base
  include Managers::SessionsHelper

  helper_method :current_user

  protect_from_forgery with: :exception

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in_manager
    redirect_to new_ticket_path unless logged_in?
  end
end
