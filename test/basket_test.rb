# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/basket'
require_relative '../lib/delivery_charge_rule'
require_relative '../lib/multi_buy_offer_rule'

class BasketTest < Minitest::Test
  def setup
    @product_catalogue = {
      'B01' => { name: 'Blue Widget', price: 7.95 },
      'G01' => { name: 'Green Widget', price: 24.95 },
      'R01' => { name: 'Red Widget', price: 32.95 }
    }

    delivery_rules_data = { 50 => 4.95, 90 => 2.95 }
    @delivery_rule = DeliveryChargeRule.new(delivery_rules_data)

    # This basket is for simple tests without special offers
    @basket = Basket.new(product_catalogue: @product_catalogue, delivery_rules: [@delivery_rule])
  end

  def test_add_items_to_basket
    @basket.add('B01')
    @basket.add('G01')
    assert_equal %w[B01 G01], @basket.items
  end

  def test_total_for_basket_under_50_dollars
    @basket.add('B01')
    @basket.add('G01')
    assert_equal 37.85, @basket.total
  end

  def test_total_for_basket_under_90_dollars
    @basket.add('R01')
    @basket.add('G01')
    assert_equal 60.85, @basket.total
  end

  def test_total_for_basket_90_or_over_without_offer
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    assert_equal 98.85, @basket.total
  end

  def test_red_widget_offer
    # The specific offer is now defined by configuring the generic rule
    # For every 2 items, 1 gets a 50% discount
    offer_rule = MultiBuyOfferRule.new(
      product_code: 'R01',
      buy_quantity: 2,
      offer_quantity: 1,
      discount_percentage: 0.5,
      product_catalogue: @product_catalogue
    )

    offer_basket = Basket.new(
      product_catalogue: @product_catalogue,
      offer_rules: [offer_rule],
      delivery_rules: [@delivery_rule]
    )

    offer_basket.add('R01')
    offer_basket.add('R01')
    assert_equal 54.37, offer_basket.total
  end

  def test_final_complex_basket
    offer_rule = MultiBuyOfferRule.new(
      product_code: 'R01',
      buy_quantity: 2,
      offer_quantity: 1,
      discount_percentage: 0.5,
      product_catalogue: @product_catalogue
    )

    complex_basket = Basket.new(
      product_catalogue: @product_catalogue,
      offer_rules: [offer_rule],
      delivery_rules: [@delivery_rule]
    )

    complex_basket.add('B01')
    complex_basket.add('B01')
    complex_basket.add('R01')
    complex_basket.add('R01')
    complex_basket.add('R01')

    assert_equal 98.27, complex_basket.total
  end
end
