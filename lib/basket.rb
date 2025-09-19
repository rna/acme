# frozen_string_literal: true

class Basket
  attr_reader :items

  def initialize(product_catalogue)
    @product_catalogue = product_catalogue
    @items = []
  end

  def add(product_code)
    @items << product_code
  end

  def total
    subtotal = @items.sum { |product_code| @product_catalogue[product_code][:price] }

    delivery_cost = 0
    if subtotal < 50
      delivery_cost = 4.95
    elsif subtotal < 90
      delivery_cost = 2.95
    end

    (subtotal + delivery_cost).round(2)
  end
end
