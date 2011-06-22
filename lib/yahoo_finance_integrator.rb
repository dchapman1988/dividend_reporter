class YahooFinanceIntegrator
  attr_accessor :stocks, :quotes
  def self.get_quotes(stock_array)
    yahoo_extended_hash = YahooFinance.get_extended_quotes(stock_array)
    yahoo_standard_hash = YahooFinance.get_standard_quotes(stock_array)
    yahoo_extended_hash.keys.each do |symbol|
      stock = Stock.find_by_symbol(symbol)
      quote = Quote.new
      stock.update_attributes( :company_name        => yahoo_extended_hash[symbol].name,
                               :symbol              => yahoo_extended_hash[symbol].symbol )
      quote.update_attributes( :ex_dividend_date    => yahoo_extended_hash[symbol].exDividendDate,
                               :dividend_pay_date   => yahoo_extended_hash[symbol].dividendPayDate,
                               :dividend_yield      => yahoo_extended_hash[symbol].dividendYield,
                               :dividends_per_share => yahoo_extended_hash[symbol].dividendPerShare,
                               :last_price          => yahoo_standard_hash[symbol].lastTrade,
                               :stock_id            => stock.id )
    end
  end

  def self.update_all_quotes
    @symbol_list = Array.new
    stocks = Stock.all
    stocks.each do |stock|
      @symbol_list.push(stock.symbol)
    end
    get_quotes(@symbol_list)
  end

  def self.add_quote_for_new_stock(single_symbol)
    @symbol_list = Array.new
    @symbol_list.push(single_symbol)
    Stock.create( :symbol => @symbol_list.first.downcase, :company_name => "new_company" )
    get_quotes(@stock_array)
  end
end

