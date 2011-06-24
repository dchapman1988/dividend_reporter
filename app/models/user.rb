class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :admin, where(:admin => true)

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :stock_watches
  has_many :stocks, :through => :stock_watches

  def unwatch stock
    watched_stock = user_stock_watches.find_by_stock_id(stock)
    watched_stock.destroy
  end

  def watch stock
    user_stock_watches.create(:stock => stock)
  end
end
