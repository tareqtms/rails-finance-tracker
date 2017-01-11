class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
    where(ticker:ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  def price
    quote = StockQuote::Stock.quote(ticker)

    return "#{quote.close} (Closing)" if quote.close
    return "#{quote.open} (Opening)" if quote.open
    return "#{quote.previous_close} (Last Closing)" if quote.previous_close
    'Unavailable'
  end
end
