task :update_stocks => :environment do
  puts "Updating stocks..."
  array = Array.new
  Stock.all.each do |stock|
    array << stock.symbol
    YahooFinanceIntegrator.new(array)
  end
end
