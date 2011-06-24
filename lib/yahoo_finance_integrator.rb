class YahooFinanceIntegrator
  attr_accessor :stocks, :quotes

  def initialize array
    if verify array
      add_quote_for_new_stock array
    else
      verify array
    end
  end

  def verify array
    raise "Must have something to integrate!" if array.nil?
    raise "Must pass in an actual array list of symbol strings!" unless array.is_a?(Array)
    raise "The list must not be empty!" if array.empty?
    true
  end

  def get_quotes array
    y_ext_hsh = YahooFinance.get_extended_quotes array
    y_std_hsh = YahooFinance.get_standard_quotes array
    y_ext_hsh.keys.each do |symbol|
      symbol.inspect
      co_name = y_ext_hsh[symbol].name
      stock = Stock.find_or_create_by_symbol_and_company_name(symbol, co_name)
      puts stock.nil?
      stock.update_attributes( :company_name        => co_name,
                               :symbol              => y_ext_hsh[symbol].symbol )
      Quote.create(            :ex_dividend_date    => y_ext_hsh[symbol].exDividendDate,
                               :dividend_pay_date   => y_ext_hsh[symbol].dividendPayDate,
                               :dividend_yield      => y_ext_hsh[symbol].dividendYield,
                               :dividends_per_share => y_ext_hsh[symbol].dividendPerShare,
                               :last_price          => y_std_hsh[symbol].lastTrade,
                               :stock               => stock
                             )
    end
  end

  def add_quote_for_new_stock(array)
    @symbol_list = Array.new
    array.each do |symbol|
      @symbol_list << symbol
      #Stock.create( :symbol => symbol, :company_name => "new_company" )
    end
    get_quotes(@symbol_list)
  end
end

