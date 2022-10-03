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

    def delete_by_id(_id)
      super
    end

    def execute(_entity)
      raise "Not Implemented"
    end
  end

  class BSTOrderRepository < BSTRepository
    include OrderRepository

    def initialize
      @entities = { SIDE[:BUY] => AVLTree.new, SIDE[:SELL] => AVLTree.new }
      @indexes = Set.new
      super
    end

    def execute(entity)
      @entities[entity.side][entity.price.to_s] = Set.new([entity])
      @indexes.add(entity.__id__)
      @indexes.find_index(entity.__id__) + 1
    end

    def find_all_orders_by(order_type)
      @entities[order_type].each(&method(:bet_element)).sort_by do |key, _value|
        BigDecimal(key)
      end.flat_map do |_element, order_set|
        order_set.flat_map do |order|
          order
        end
      end
    end

    private

    def bet_element(element)
      element
    end
  end
end
