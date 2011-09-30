class Admin::StocksController < AdminController

  def create
    # Yahoo finance takes care of this one
  end

  def destroy
    if Stock.find(params[:id]).destroy
      flash[:info] = "Stock successfully removed."
      redirect_to admin_panel_path
    else
      flash[:error] = "Failed to remove stock!"
      redirect_to admin_panel_path
    end
  end

  def update_multiple
    if params[:commit] == "Update selected" && !params[:selected].nil?
      number_of_updated_quotes = pluralize(params[:selected].count, "stock")
      process_updates
      flash[:notice] = "Updated #{number_of_updated_quotes}."
      redirect_to request.env["HTTP_REFERER"]
    elsif params[:commit] == "Remove selected" && !params[:selected].nil?
      number_of_removed_stocks = pluralize(params[:selected].count, "stock")
      remove_multiple
      flash[:info] = "Removed #{number_of_removed_stocks}."
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Select something first."
      redirect_to admin_panel_path
    end
  end

  def edit
    # Yahoo finance takes care of this one.
  end

  def new
    @symbol_list = params[:symbol].split(",").map{ |s| s.strip }
    if @symbol_list.any?
      YahooFinanceIntegrator.new @symbol_list
      number_of_added_stocks = pluralize(@symbol_list.count, 'Stock')
      flash[:notice] = "Added #{number_of_added_stocks}"
      redirect_to admin_panel_path
    else
      flash[:error] = "Didn\'t find any symbols."
      redirect_to admin_panel_path
    end
  end

  def update
    @symbol_list = Array.new
    stocks = Stock.all
    stocks.each do |stock|
      @symbol_list << stock.symbol
    end
    YahooFinanceIntegrator.get_quotes(@symbol_list)
    flash[:notice] = "Stocks updated."
    redirect_to admin_panel_path
  end

protected

  def remove_multiple
    if params[:selected].any?
      params[:selected].keys.each do |id|
        Stock.find(id.to_i).destroy
      end
    end
  end

  def process_updates
    array = params[:selected] if params[:selected].any?
    array.each do |id|
      symbols = []
      symbols << Stock.find(id[1].to_i).symbol
      YahooFinanceIntegrator.new(symbols)
    end
  end

end
