# frozen_string_literal: true

require "test_helper"

class TestRuby < Minitest::Test
  def test_market_should_submit_one_buy_order
    market = Market.new
    order = OrderBuilder.buy

    order_id = market.submit(order)

    assert_equal(1, order_id)
    assert_equal({ "bids": [[order.euro, order.bitcoin.to_s("F")]], "asks": [] }, market.market_depth)
  end

  def test_should_submit_one_sell_order
    market = Market.new
    order = OrderBuilder.sell

    market.submit(order)

    assert_equal({ "bids": [], "asks": [[order.euro, order.bitcoin.to_s("F")]] }, market.market_depth)
  end
end

require_relative "../lib/market"
require_relative "../lib/buy_order"
require_relative "order_builder"
