class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    unless current_user.stock_watches.any?
      flash[:info] = "You need to add some stocks first."
      redirect_to root_path 
    end
    @stocks = current_user.stocks
  end

end
