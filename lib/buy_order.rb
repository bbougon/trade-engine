# frozen_string_literal: true

require "bigdecimal"
require 'bigdecimal/util'

class BuyOrder
  def initialize(euro, bitcoin)
    @euro = euro
    @bitcoin = BigDecimal(bitcoin)
  end

  attr_reader :euro, :bitcoin
end

