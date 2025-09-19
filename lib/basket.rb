# frozen_string_literal: true

class Basket
  attr_reader :items

  def initialize(product_catalogue:, pricing_rules: [])
    @product_catalogue = product_catalogue
    @pricing_rules = pricing_rules
    @items = []
  end

  def add(product_code)
    @items << product_code
  end

  def total
    subtotal = @items.sum { |product_code| @product_catalogue[product_code][:price] }

    adjustments = @pricing_rules.sum do |rule|
      rule.apply(subtotal, @items)
    end

    (subtotal + adjustments).round(2)
  end
end
