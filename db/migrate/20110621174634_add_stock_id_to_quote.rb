class AddStockIdToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :stock_id, :integer
  end
end
