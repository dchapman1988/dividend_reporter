class AddUserStockWatches < ActiveRecord::Migration
  def self.up
    create_table :user_stock_watches do |t|
      t.integer :user_id
      t.integer :stock_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_stock_watches
  end
end
