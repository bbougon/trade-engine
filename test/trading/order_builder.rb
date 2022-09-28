# frozen_string_literal: true

require "faker"
class OrderBuilder
  def self.buy(euro = Faker::Number.decimal(l_digits: 2).to_s, bitcoin = Faker::Number.decimal(l_digits: 8).to_s)
    BuyOrder.new(euro, bitcoin)
  end

  def self.sell(euro = Faker::Number.decimal(l_digits: 2).to_s, bitcoin = Faker::Number.decimal(l_digits: 8).to_s)
    SellOrder.new(euro, bitcoin)
  end
end
