# frozen_string_literal: true

class Market
  def initialize
    @repository = []
    super
  end

  def submit(order)
    @repository.push(order)
    @repository.index(order) + 1
  end

  def market_price; end

  def market_depth
    buy_orders = @repository.find_all { |order| order.order_type == ORDER_TYPE[:BUY]}.map { |order| [order.euro, order.bitcoin.to_s('F')] }
    sell_orders = @repository.find_all { |order| order.order_type == ORDER_TYPE[:SELL]}.map { |order| [order.euro, order.bitcoin.to_s('F')] }
    { bids: buy_orders, asks: sell_orders }
  end

  def cancel_order(id)
    ;
  end
end
