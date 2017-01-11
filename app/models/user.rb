class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def can_add_stock?(stock_ticker)
    under_stock_limit? && !stock_already_added?(stock_ticker)
  end

  def under_stock_limit?
    (user_stocks.count < 10)
  end

  def stock_already_added?(stock_ticker)
    stock = Stock.find_by_ticker(stock_ticker)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anynonimous"
  end
end
