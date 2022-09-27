# frozen_string_literal: true

require "test_helper"

class TestRuby < Minitest::Test
  def test_market_should_submit_one_buy_order
    market = Market.new

    order_id = market.submit(BuyOrder.new("1.40", "3.375"))

    assert_equal(1, order_id)
    assert_equal({ "bids": [%w[1.40 3.375]], "asks": [] }, market.market_depth)
  end

  def test_should_submit_one_sell_order
    market = Market.new

    market.submit(SellOrder.new("1.40", "3.375"))

    assert_equal({ "bids": [], "asks": [%w[1.40 3.375]] }, market.market_depth)
  end
end

require_relative "../lib/market"
require_relative "../lib/buy_order"
