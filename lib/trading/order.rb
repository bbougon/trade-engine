# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Currency
  def initialize(currency, multiplier)
    @position = currency.index(".")
    @multiplier = multiplier
    @value = BigDecimal(currency).mult(@multiplier, 0).to_i
  end

  def to_s
    @value.to_s.insert(@position, ".")
  end

  def value
    (@value / @multiplier).to_f
  end
end

class Bitcoin < Currency
  def self.create(bitcoin)
    Bitcoin.new(bitcoin, 100_000_000)
  end
end

class Euro < Currency
  def self.create(euro)
    Euro.new(euro, 100)
  end
end

ORDER_TYPE = {
  BUY: 1,
  SELL: 2
}.freeze
class Order
  def initialize(euro, bitcoin)
    @euro = Euro.create(euro)
    @bitcoin = Bitcoin.create(bitcoin)
  end

  attr_reader :euro, :bitcoin, :order_type
end

class BuyOrder < Order
  def initialize(euro, bitcoin)
    @order_type = ORDER_TYPE[:BUY]
    super euro, bitcoin
  end
end

class SellOrder < Order
  def initialize(euro, bitcoin)
    @order_type = ORDER_TYPE[:SELL]
    super euro, bitcoin
  end
end
