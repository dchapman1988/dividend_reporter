class AdminController < ApplicationController

  def index
    @stocks = Stock.all
  end

  def update_quotes
    y_integrator = YahooFinanceIntegrator.new
    if y_integrator.update_all_quotes
     redirect_to admin_panel_path, :notice => "Update successful!"
    else
      redirect_to admin_panel_path, :notice => "Update failed!"
    end
  end

  def remove_stock
    if Stock.find(params[:id]).destroy
      redirect_to admin_panel_path, :notice => "Stock successfully removed!"
    else
      redirect_to admin_panel_path, :notice => "Failed to remove stock!"
    end
  end

  def add_stock
    @symbol = params[:symbol]
    y_integrator = YahooFinanceIntegrator.new
    y_integrator.add_quote_for_new_stock @symbol
    redirect_to admin_panel_path
  end
end
