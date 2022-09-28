# frozen_string_literal: true

require_relative "../../../repository"
require_relative "../../../order_repository"

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
      @entities = @entities.reject.with_index { |_, index| index == id - 1 }
    end
  end

  class MemoryOrderRepository < MemoryRepository
    include OrderRepository

    def find_all_orders_by(order_type)
      @entities.find_all do |order|
        order.order_type == order_type
      end
    end
  end
end
