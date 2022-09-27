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
    orders = @repository.map { |order| [order.euro, order.bitcoin.to_s('F')] }
    { bids: orders }
  end

  def cancel_order(id)
    ;
  end
end
