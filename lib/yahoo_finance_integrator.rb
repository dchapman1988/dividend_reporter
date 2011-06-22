class YahooFinanceIntegrator
  attr_accessor :stocks, :quotes
  def get_quotes(array)
    y_ext_hsh = YahooFinance.get_extended_quotes(stock_array)
    y_std_hsh = YahooFinance.get_standard_quotes(stock_array)
    y_ext_hsh.keys.each do |symbol|
      stock = Stock.find_by_symbol(symbol)
      quote = Quote.new
      stock.update_attributes( :company_name        => y_ext_hsh[symbol].name,
                               :symbol              => y_ext_hsh[symbol].symbol )
      quote.update_attributes( :ex_dividend_date    => y_ext_hsh[symbol].exDividendDate,
                               :dividend_pay_date   => y_ext_hsh[symbol].dividendPayDate,
                               :dividend_yield      => y_ext_hsh[symbol].dividendYield,
                               :dividends_per_share => y_ext_hsh[symbol].dividendPerShare,
                               :last_price          => y_std_hsh[symbol].lastTrade,
                               :stock_id            => stock.id )
    end
  end

  def update_all_quotes
    @symbol_list = Array.new
    stocks = Stock.all
    stocks.each do |stock|
      @symbol_list << stock.symbol
    end
    get_quotes(@symbol_list)
  end

  def add_quote_for_new_stock(array)
    @symbol_list = Array.new
    array.each do |symbol|
      @symbol_list << symbol
      Stock.create( :symbol => @symbol_list.first.upcase, :company_name => "new_company" )
    end
    get_quotes(@symbol_list)
  end
end

