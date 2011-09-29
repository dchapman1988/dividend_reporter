class ApplicationController < ActionController::Base
  protect_from_forgery

  def pluralize(count, singular, plural = nil)
    "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ?
    singular :
    (plural || singular.pluralize))
  end

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "Only admins can access this page."
      redirect_to root_path
    end
  end
end
