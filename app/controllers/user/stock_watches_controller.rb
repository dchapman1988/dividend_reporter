class User::StockWatchesController < UsersController

  def index
  end

  def new
    @stock_watch = StockWatch.new
  end

  def create
    if @stock_watch.save
      flash[:notice] = "Stock watch created!"
      redirect_to root_path
    else
      flash[:error] = "Failed to watch the stock!"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    if @user.stock_watch.destroy
      flash[:info] = "Stock watch removed!"
      redirect_to root_path
    else
      flash[:error] = "Failed to remove stock watch!"
      redirect_to user_path(current_user)
    end
  end

  def update_multiple
    if params[:commit] == "Watch selected" && !params[:selected].nil?
      number_of_updated_stocks = pluralize(params[:selected].count, "stock")
      watch_multiple
      flash[:notice] = "Added #{number_of_updated_stocks} to your watch list."
      redirect_to root_path
    elsif params[:commit] == "Unwatch selected" && !params[:selected].nil?
      number_of_removed_stocks = pluralize(params[:selected].count, "stock")
      unwatch_multiple
      flash[:alert] = "Removed #{number_of_removed_stocks}."
      redirect_to user_path(current_user)
    else
      flash[:info] = "Select something first."
      redirect_to user_path(current_user)
    end
  end

  protected
  def unwatch_multiple
    StockWatch.delete_all(["stock_watches.stock_id IN (?) AND stock_watches.user_id = ?", params[:selected].keys, current_user.id]) if params[:selected].any?
  end

  def watch_multiple
    params[:selected].keys.each do |id|
      current_user.stock_watches.create(:stock_id => id)
    end
  end
end
