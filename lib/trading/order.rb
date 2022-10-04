# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Currency
  def initialize(currency, multiplier)
    @position = currency.index(".")
    @multiplier = BigDecimal(multiplier.to_s)
    @value = BigDecimal(currency).mult(@multiplier, 0).to_i
  end

  def to_s
    return BigDecimal(value.to_s).to_s("F") if @multiplier > @value

    @value.to_s.insert(@position, ".")
  end

  def value
    (@value / @multiplier).to_f
  end
end

class Bitcoin < Currency
  def self.create(bitcoin)
    Bitcoin.new(bitcoin, 10**8)
  end
end

class Euro < Currency
  def self.create(euro)
    Euro.new(euro, 10**2)
  end
end

SIDE = {
  BUY: 1,
  SELL: 2
}.freeze
class Order
  def initialize(price, amount)
    @price = Euro.create(price)
    @amount = Bitcoin.create(amount)
  end

  attr_reader :price, :amount, :side
end

class BuyOrder < Order
  def initialize(price, amount)
    @side = SIDE[:BUY]
    super price, amount
  end
end

class SellOrder < Order
  def initialize(price, amount)
    @side = SIDE[:SELL]
    super price, amount
  end
end
