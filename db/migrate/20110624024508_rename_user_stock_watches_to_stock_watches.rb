class RenameUserStockWatchesToStockWatches < ActiveRecord::Migration
  def self.up
    rename_table :user_stock_watches, :stock_watches
  end

  def self.down
    rename_table :stock_watches, :user_stock_watches
  end
end
