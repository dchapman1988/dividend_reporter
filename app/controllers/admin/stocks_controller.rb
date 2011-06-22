class Admin::StocksController < AdminController

  def create
  end

  def destroy
    if Stock.find(params[:id]).destroy
      redirect_to admin_panel_path, :success => "Stock successfully removed!"
    else
      redirect_to admin_panel_path, :error => "Failed to remove stock!"
    end
  end

  def edit
  end

  def new
    @symbol_list = params[:symbol].split(",").map{|s| s.strip}
    YahooFinanceIntegrator.
    y_integrator = YahooFinanceIntegrator.new @symbol_list
    redirect_to admin_panel_path
  end
end
