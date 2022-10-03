# frozen_string_literal: true

require "test_helper"

require_relative "../../../../lib/infrastructure/repositories/bst/repositories"

require_relative "../../../trading/order_builder"
require_relative "../../../../lib/trading/order"

class TestBSTRepository < Minitest::Test
  def test_should_persist_orders
    repository = BSTRepositories::BSTOrderRepository.new
    first_buy_order = OrderBuilder.buy("5.00", "0.00000002")
    second_buy_order = OrderBuilder.buy("6.00", "0.00000003")
    third_buy_order = OrderBuilder.buy("3.00", "0.00000001")
    fourth_buy_order = OrderBuilder.buy("12500.00", "0.86718291")
    first_sell_order = OrderBuilder.sell("5.00", "0.00000002")
    second_sell_order = OrderBuilder.sell("6.00", "0.00000003")
    third_sell_order = OrderBuilder.sell("3.00", "0.00000001")
    fourth_sell_order = OrderBuilder.sell("12500.00", "0.86718291")

    first_id = repository.persist(first_buy_order)
    second_id = repository.persist(second_buy_order)
    third_id = repository.persist(third_buy_order)
    fourth_id = repository.persist(fourth_buy_order)
    repository.persist(first_sell_order)
    repository.persist(second_sell_order)
    repository.persist(third_sell_order)
    eigth_id = repository.persist(fourth_sell_order)

    assert_equal(
      [third_buy_order, first_buy_order, second_buy_order, fourth_buy_order], repository.find_all_orders_by(SIDE[:BUY])
    )
    assert_equal(
      [third_sell_order, first_sell_order, second_sell_order,
       fourth_sell_order], repository.find_all_orders_by(SIDE[:SELL])
    )
    assert_equal([1, 2, 3, 4, 8], [first_id, second_id, third_id, fourth_id, eigth_id])
  end

  def test_should_delete_by_id
    repository = BSTRepositories::BSTOrderRepository.new
    first_buy_order = OrderBuilder.buy("5.00", "0.00000002")
    second_buy_order = OrderBuilder.buy("6.00", "0.00000003")
    third_buy_order = OrderBuilder.buy("3.00", "0.00000001")
    first_sell_order = OrderBuilder.sell("5.00", "0.00000002")
    second_sell_order = OrderBuilder.sell("6.00", "0.00000003")
    repository.persist(first_buy_order)
    second_id = repository.persist(second_buy_order)
    repository.persist(third_buy_order)
    repository.persist(first_sell_order)
    fifth_id = repository.persist(second_sell_order)

    repository.delete_by_id(second_id)
    repository.delete_by_id(fifth_id)

    assert_equal(
      [third_buy_order, first_buy_order], repository.find_all_orders_by(SIDE[:BUY])
    )
    assert_equal(
      [first_sell_order], repository.find_all_orders_by(SIDE[:SELL])
    )
  end

  def test_should_delete_many_orders
    repository = BSTRepositories::BSTOrderRepository.new
    first_buy_order = OrderBuilder.buy("5.00", "0.00000002")
    second_buy_order = OrderBuilder.buy("6.00", "0.00000003")
    third_buy_order = OrderBuilder.buy("3.00", "0.00000001")
    first_sell_order = OrderBuilder.sell("5.00", "0.00000002")
    second_sell_order = OrderBuilder.sell("6.00", "0.00000003")
    third_sell_order = OrderBuilder.sell("7.00", "0.00000003")
    first_id = repository.persist(first_buy_order)
    second_id = repository.persist(second_buy_order)
    repository.persist(third_buy_order)
    fourth_id = repository.persist(first_sell_order)
    fifth_id = repository.persist(second_sell_order)
    repository.persist(third_sell_order)

    repository.delete_by_id(first_id)
    repository.delete_by_id(second_id)
    repository.delete_by_id(fourth_id)
    repository.delete_by_id(fifth_id)

    assert_equal(
      [third_buy_order], repository.find_all_orders_by(SIDE[:BUY])
    )
    assert_equal(
      [third_sell_order], repository.find_all_orders_by(SIDE[:SELL])
    )
  end
end
