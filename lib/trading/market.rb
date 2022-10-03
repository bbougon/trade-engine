# frozen_string_literal: true

require_relative "../infrastructure/repositories/bst/repositories"
class Market
  def initialize
    @repository = BSTRepositories::BSTOrderRepository.new
    super
  end

  def submit(order)
    @repository.persist(order)
  end

  def market_price
    maximum_buy_price = @repository.find_all_orders_by(SIDE[:BUY]).map { |order| order.price.value }.max
    minimum_sell_price = @repository.find_all_orders_by(SIDE[:SELL]).map { |order| order.price.value }.min
    ((maximum_buy_price + minimum_sell_price) / 2).to_f
  end

  def market_depth
    buy_orders = @repository.find_all_orders_by(SIDE[:BUY]).reverse.map do |order|
      [order.price.to_s, order.amount.to_s]
    end
    sell_orders = @repository.find_all_orders_by(SIDE[:SELL]).map do |order|
      [order.price.to_s, order.amount.to_s]
    end
    { bids: buy_orders, asks: sell_orders }
  end

  def cancel_order(id)
    @repository.delete_by_id(id)
  end
end
