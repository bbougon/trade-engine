# frozen_string_literal: true

require_relative "../../../repository"
require_relative "../../../trading/order_repository"

module MemoryRepositories
  class MemoryRepository
    include Repository

    def initialize
      @entities = Set.new
    end

    def persist(entity)
      @entities.add(entity)
      @entities.find_index(entity) + 1
    end

    def delete_by_id(id)
      @entities = @entities.reject.with_index { |_, index| index == id - 1 }.to_set
    end
  end

  class MemoryOrderRepository < MemoryRepository
    include OrderRepository

    def find_all_orders_by(order_type)
      @entities.find_all do |order|
        order.side == order_type
      end
    end
  end
end
