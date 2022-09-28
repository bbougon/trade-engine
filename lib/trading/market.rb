# frozen_string_literal: true

require_relative "../infrastructure/repositories/memory/repositories"
class Market
  def initialize
    @repository = MemoryRepositories::MemoryOrderRepository.new
    super
  end

  def submit(order)
    @repository.persist(order)
  end

  def market_price
    maximum_buy_price = @repository.find_all_orders_by(ORDER_TYPE[:BUY]).map { |order| order.euro.value }.max
    minimum_sell_price = @repository.find_all_orders_by(ORDER_TYPE[:SELL]).map { |order| order.euro.value }.min
    ((maximum_buy_price + minimum_sell_price) / 2).to_f
  end

  def market_depth
    buy_orders = @repository.find_all_orders_by(ORDER_TYPE[:BUY]).map { |order| [order.euro.to_s, order.bitcoin.to_s] }
    sell_orders = @repository.find_all_orders_by(ORDER_TYPE[:SELL]).map do |order|
      [order.euro.to_s, order.bitcoin.to_s]
    end
    { bids: buy_orders, asks: sell_orders }
  end

  def cancel_order(id)
    @repository.delete_by_id(id)
  end
end
