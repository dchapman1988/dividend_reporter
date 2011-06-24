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

  def create
  end

end
