class AddCompanyNameToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :company_name, :string
  end
end
