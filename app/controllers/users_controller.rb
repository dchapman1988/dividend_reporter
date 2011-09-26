class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if current_user
      unless current_user.stock_watches != nil
        redirect_to root_path 
        flash[:info] = "You need to add some stocks first."
      end
      @stocks = current_user.stocks
    else
      redirect_to new_user_session_path
    end
  end

end
