# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/basket'
require_relative '../lib/delivery_charge_rule'

class BasketTest < Minitest::Test
  def setup
    product_catalogue = {
      'B01' => { name: 'Blue Widget', price: 7.95 },
      'G01' => { name: 'Green Widget', price: 24.95 },
      'R01' => { name: 'Red Widget', price: 32.95 }
    }

    delivery_rules_data = {
      50 => 4.95,
      90 => 2.95
    }

    delivery_rule = DeliveryChargeRule.new(delivery_rules_data)

    @basket = Basket.new(product_catalogue: product_catalogue, pricing_rules: [delivery_rule])
  end

  def test_add_items_to_basket
    @basket.add('B01')
    @basket.add('G01')

    assert_equal %w[B01 G01], @basket.items
  end

  def test_total_for_basket_under_50_dollars
    @basket.add('B01')
    @basket.add('G01')
    # Subtotal: 32.90, Delivery: 4.95
    assert_equal 37.85, @basket.total
  end

  def test_total_for_basket_under_90_dollars
    @basket.add('R01')
    @basket.add('G01')
    # Subtotal: 57.90, Delivery: 2.95
    assert_equal 60.85, @basket.total
  end

  def test_total_for_basket_90_or_over
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    # Subtotal: 98.85, Delivery: 0
    assert_equal 98.85, @basket.total
  end
end
