class Admin::StocksController < AdminController

  def create
    # Yahoo finance takes care of this one
  end

  def destroy
    if Stock.find(params[:id]).destroy
      redirect_to admin_panel_path
      flash[:info] = "Stock successfully removed."
    else
      redirect_to admin_panel_path
      flash[:error] = "Failed to remove stock!"
    end
  end

  def update_multiple
    if params[:commit] == "Update selected" && !params[:selected].nil?
      number_of_updated_quotes = pluralize(params[:selected].count, "stock")
      process_updates
      redirect_to admin_panel_path, :notice => "Updated #{number_of_updated_quotes}."
    elsif params[:commit] == "Remove selected" && !params[:selected].nil?
      number_of_removed_stocks = pluralize(params[:selected].count, "stock")
      remove_multiple
      redirect_to admin_panel_path
      flash[:info] = "Removed #{number_of_removed_stocks}."
    else
      redirect_to admin_panel_path
      flash[:error] = "Select something first."
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
      redirect_to admin_panel_path, :notice => "Added #{number_of_added_stocks}"
    else
      redirect_to admin_panel_path
      flash[:error] = "Didn\'t find any symbols. Was the text area empty? ;-)"
    end
  end

  def update
    @symbol_list = Array.new
    stocks = Stock.all
    stocks.each do |stock|
      @symbol_list << stock.symbol
    end
    YahooFinanceIntegrator.get_quotes(@symbol_list)
    redirect_to admin_panel_path, :notice => "Stocks successfully updated!"
  end

  def pluralize(count, singular, plural = nil)
    "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

protected

  def remove_multiple
    Stock.destroy_all(["stocks.id IN (?)", params[:selected].keys] ) if params[:selected].any?
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
