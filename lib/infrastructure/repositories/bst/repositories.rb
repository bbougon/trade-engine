# frozen_string_literal: true

require_relative "../../../repository"
require_relative "../../../trading/order_repository"
require "avl_tree"

module BSTRepositories
  class BSTRepository
    include Repository

    def persist(entity)
      execute(entity)
    end

    def delete_by_id(id)
      delete(id)
    end

    def execute(_entity)
      raise "Not Implemented"
    end

    def delete(_id)
      raise "Not Implemented"
    end
  end

  class BSTOrderRepository < BSTRepository
    include OrderRepository

    def initialize
      @entities = { SIDE[:BUY] => AVLTree.new, SIDE[:SELL] => AVLTree.new }
      @indexes = {}
      super
    end

    def execute(entity)
      @entities[entity.side][entity.price.to_s] = Set.new([entity])
      index = @indexes.size + 1
      @indexes.store(index, entity.__id__)
      index
    end

    def delete(id)
      order_id = @indexes.fetch(id)
      @entities[SIDE[:BUY]].each_value { |order_set| delete_order(order_id, order_set) }
      @entities[SIDE[:SELL]].each_value { |order_set| delete_order(order_id, order_set) }
      @indexes.delete(id)
    end

    def find_all_orders_by(order_type)
      @entities[order_type].each(&method(:get_element)).sort_by do |key, _value|
        BigDecimal(key)
      end.flat_map do |_element, order_set|
        order_set.flat_map do |order|
          order
        end
      end
    end

    private

    def delete_order(order_id, order_set)
      order_set.delete_if { |order| order.__id__ == order_id }
    end

    def get_element(element)
      element
    end
  end
end
