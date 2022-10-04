# frozen_string_literal: true

require "test_helper"

class TestOrder < Minitest::Test
  def test_order_should_have_precision
    assert_equal({ price: "1.40", amount: "1.75000000" },
                 { price: BuyOrder.new("1.40", "1.75").price.to_s, amount: BuyOrder.new("1.40", "1.75").amount.to_s })
    assert_equal({ price: "1.55", amount: "1234.45162879" },
                 { price: BuyOrder.new("1.55", "1234.45162879").price.to_s,
                   amount: BuyOrder.new("1.55", "1234.45162879").amount.to_s })
    assert_equal({ price: "0.15", amount: "0.00000001" },
                 { price: BuyOrder.new("0.15", "0.00000001").price.to_s,
                   amount: BuyOrder.new("0.15", "0.00000001").amount.to_s })
  end
end

require_relative "../../lib/trading/order"
