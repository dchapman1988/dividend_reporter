class StocksController < ApplicationController
  def new
  end

  def index
    if user_signed_in?
      @stocks = Stock.all
    else
      flash.now[:info] = "TIP:  Login to watch and view more information on the stocks below."
      @stocks = Stock.all
    end
  end


  def show 
    if user_signed_in?
      @stock = Stock.find(params[:id])
    else
      flash[:info] = "Sign in to view a company's stock information."
      redirect_to new_user_session_path
    end
  end

  def create
  end

end
