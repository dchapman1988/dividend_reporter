class StocksController < ApplicationController

  def index
    @title = "Home"
    @stocks = Stock.all
  end

  def show 
    @title = "Stock"
    @stock = Stock.find(params[:id])
  end

  def watch
    @title = "Watch"
  end
end
