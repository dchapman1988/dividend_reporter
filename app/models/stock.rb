class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol
  validates_presence_of :symbol, :company_name
  validates_format_of :symbol, :with => /\D/
  has_many :quotes
  has_many :user_stock_watches
  has_many :users, :through => :user_stock_watches
end
