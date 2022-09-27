# frozen_string_literal: true

require "test_helper"

class TestOrder < Minitest::Test
  def test_order_should_have_precision
    assert_equal("1.75000000", BuyOrder.new("1.40", "1.75").bitcoin.to_s)
    assert_equal("1234.45162879", BuyOrder.new("1.40", "1234.45162879").bitcoin.to_s)
  end
end

require_relative "../lib/order"
