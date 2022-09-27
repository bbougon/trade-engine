# frozen_string_literal: true

require "bigdecimal"
require 'bigdecimal/util'

ORDER_TYPE = {
  BUY: 1,
  SELL: 2
}
class Order
  def initialize(euro, bitcoin)
    @euro = euro
    @bitcoin = BigDecimal(bitcoin)
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
