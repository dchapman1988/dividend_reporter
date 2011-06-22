class UsersController < ApplicationController

  def show
    if current_user
      unless current_user.user_stock_watches != nil
        redirect_to root_path, :error => "You need to add some stocks first."
      end
      @stocks = current_user.stocks
    else
      redirect_to new_user_session_path
    end
  end

  def remove_watch
    if Stock.find(params[:id])
      @stock = Stock.find(params[:id])
      if current_user
        current_user.unwatch @stock
        redirect_to user_path(current_user), :info => "Stock removed!"
      else
        redirect_to user_path(current_user), :info => "You are not watching this stock..."
      end
    end
  end
end
