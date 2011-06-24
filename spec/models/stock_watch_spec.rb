require 'spec_helper'

describe StockWatch do

  before(:each) do
    @stock_watch = StockWatch.new
  end

  it "should respond to a user's id" do
    @stock_watch.respond_to?(:user_id)
    response.should be_true
  end
end
