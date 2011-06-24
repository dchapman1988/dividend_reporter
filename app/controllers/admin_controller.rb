class AdminController < ApplicationController

  def index
    if current_user.admin
      @stocks = Stock.all
    else
      redirect_to root_path
      flash[:error] = "You must be an administrator to access this page!"
    end
  end
end
