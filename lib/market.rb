# frozen_string_literal: true

class Market
  def initialize
    @repository = Set.new
    super
  end

  def submit(order)
    @repository.add(order)
    @repository.find_index(order) + 1
  end

  def market_price
    maximum_buy_price = find_all_orders_by(ORDER_TYPE[:BUY]).map { |order| order.euro.value }.max
    minimum_sell_price = find_all_orders_by(ORDER_TYPE[:SELL]).map { |order| order.euro.value }.min
    ((maximum_buy_price + minimum_sell_price) / 2).to_f
  end

  def market_depth
    buy_orders = find_all_orders_by(ORDER_TYPE[:BUY]).map { |order| [order.euro.to_s, order.bitcoin.to_s] }
    sell_orders = find_all_orders_by(ORDER_TYPE[:SELL]).map { |order| [order.euro.to_s, order.bitcoin.to_s] }
    { bids: buy_orders, asks: sell_orders }
  end

  def cancel_order(id)
    @repository = @repository.reject.with_index { |_, index| index == id - 1 }
  end

  private

  def find_all_orders_by(order_type)
    @repository.find_all do |order|
      order.order_type == order_type
    end
  end
end
