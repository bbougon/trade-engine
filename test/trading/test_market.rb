# frozen_string_literal: true

require "test_helper"

class TestMarket < Minitest::Test
  def test_market_should_submit_one_buy_order
    market = Market.new
    order = OrderBuilder.buy

    order_id = market.submit(order)

    assert_equal(1, order_id)
    assert_equal({ "bids": [[order.euro.to_s, order.bitcoin.to_s]], "asks": [] }, market.market_depth)
  end

  def test_should_submit_one_sell_order
    market = Market.new
    order = OrderBuilder.sell

    market.submit(order)

    assert_equal({ "bids": [], "asks": [[order.euro.to_s, order.bitcoin.to_s]] }, market.market_depth)
  end

  def test_should_display_market_price
    market = Market.new
    first_order = OrderBuilder.buy("1.80", "1.5")
    second_order = OrderBuilder.buy("2.00", "1.0")
    third_order = OrderBuilder.sell("3.2", "1.5")
    fourth_order = OrderBuilder.sell("3.0", "1.0")
    market.submit(first_order)
    market.submit(second_order)
    market.submit(third_order)
    market.submit(fourth_order)

    price = market.market_price

    assert_equal(2.5, price)
    assert_equal(
      { "asks": [[third_order.euro.to_s, third_order.bitcoin.to_s],
                 [fourth_order.euro.to_s, fourth_order.bitcoin.to_s]],
        "bids": [[first_order.euro.to_s, first_order.bitcoin.to_s],
                 [second_order.euro.to_s, second_order.bitcoin.to_s]] }, market.market_depth
    )
  end

  def test_should_cancel_order
    market = Market.new
    sell_order = OrderBuilder.sell
    market.submit(sell_order)
    order_id = market.submit(OrderBuilder.buy)

    market.cancel_order(order_id)

    assert_equal({ "asks": [[sell_order.euro.to_s, sell_order.bitcoin.to_s]], "bids": [] }, market.market_depth)
  end
end

require_relative "../../lib/trading/market"
require_relative "../../lib/trading/order"
require_relative "order_builder"
