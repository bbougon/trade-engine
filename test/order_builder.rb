# frozen_string_literal: true

require "faker"
class OrderBuilder
  def self.buy
    BuyOrder.new(Faker::Number.decimal(l_digits: 2).to_s, Faker::Number.decimal(l_digits: 8).to_s)
  end

  def self.sell
    SellOrder.new(Faker::Number.decimal(l_digits: 2).to_s, Faker::Number.decimal(l_digits: 8).to_s)
  end
end
