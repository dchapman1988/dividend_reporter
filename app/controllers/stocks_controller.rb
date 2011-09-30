class StocksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def new
  end

  def index
    if user_signed_in?
      @stocks = Stock.paginate(:page => params[:page], :per_page => 15).order("symbol")
    else
      flash.now[:info] = "TIP:  Login to watch and view more information on the stocks below."
      @stocks = Stock.paginate(:page => params[:page], :per_page => 15).order("symbol")
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
