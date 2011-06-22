class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.float :last_price
      t.float :dividend_yield
      t.float :dividends_per_share
      t.string :ex_dividend_date
      t.string :dividend_pay_date

      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
