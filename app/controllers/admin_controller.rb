class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def index
    @stocks = Stock.paginate(:page => params[:page], :per_page => 20)
  end
end
