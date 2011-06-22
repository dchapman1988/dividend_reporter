require File.expand_path(File.join(Rails.root, 'lib', 'yahoo_finance_integrator.rb'))
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
end
