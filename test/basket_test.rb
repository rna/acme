# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/basket'
class BasketTest < Minitest::Test
  def setup
    product_catalogue = {
      'B01' => { name: 'Blue Widget', price: 7.95 },
      'G01' => { name: 'Green Widget', price: 24.95 },
      'R01' => { name: 'Red Widget', price: 32.95 }
    }

    @basket = Basket.new(product_catalogue)
  end

  def test_add_items_to_basket
    @basket.add('B01')
    @basket.add('G01')

    assert_equal %w[B01 G01], @basket.items
  end
end
