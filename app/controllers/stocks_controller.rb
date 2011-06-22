class StocksController < ApplicationController
  def new
  end

  def index
    @stocks = Stock.all
  end

  def show 
    @stock = Stock.find(params[:id])
  end

  def watch
    flash[:notice] = "Must login in to watch a stock." unless current_user && stock = Stock.find(params[:id])
    current_user.watch Stock.find(params[:id])
    redirect_to root_path
  end
end
