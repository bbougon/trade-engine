# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Bitcoin
  def initialize(value, position)
    @value = value
    @position = position
  end

  def self.create(bitcoin)
    dot_position = bitcoin.index(".")
    bitcoin_integer_value = BigDecimal(bitcoin).mult(100_000_000, 0).to_i
    Bitcoin.new(bitcoin_integer_value, dot_position)
  end

  def to_s
    @value.to_s.insert(@position, ".")
  end
end

ORDER_TYPE = {
  BUY: 1,
  SELL: 2
}.freeze
class Order
  def initialize(euro, bitcoin)
    @euro = euro
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
