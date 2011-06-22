class StocksController < ApplicationController
  def new
  end

  def index
    @stocks = Stock.all
  end

  def show 
    if user_signed_in?
      @stock = Stock.find(params[:id])
    else
      redirect_to new_user_session_path 
      flash[:info] = "Sign in to view a company's stock information."
    end
  end

  def watch
    unless current_user
      redirect_to new_user_session_path, :info => "You must be signed in to watch a stock."
    end
    if stock = Stock.find(params[:id])
      current_user.watch Stock.find(params[:id])
      redirect_to root_path, :notice => "You are now watching #{stock.company_name}!"
    end
  end
end
