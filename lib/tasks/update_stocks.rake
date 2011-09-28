task :update_stocks => :development do
  puts "Updating stocks..."
  array = Array.new
  Stock.all.each do |stock|
    array << stock.symbol
    YahooFinanceIntegrator.new(array)
  end
end
