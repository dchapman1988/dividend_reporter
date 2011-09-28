class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "Only admins can access this page."
      redirect_to root_path
    end
  end
end
