# frozen_string_literal: true

class Basket
  attr_reader :items

  def initialize(product_catalogue:, offer_rules: [], delivery_rules: [])
    @product_catalogue = product_catalogue
    @offer_rules = offer_rules
    @delivery_rules = delivery_rules
    @items = []
  end

  def add(product_code)
    @items << product_code
  end

  def total
    subtotal = @items.sum { |product_code| @product_catalogue[product_code][:price] }

    offer_adjustments = @offer_rules.sum do |rule|
      rule.apply(subtotal, @items)
    end

    subtotal_after_offers = subtotal + offer_adjustments

    # Applying delivery rules based on the post-offer subtotal
    delivery_charge = @delivery_rules.sum do |rule|
      rule.apply(subtotal_after_offers, @items)
    end

    (subtotal_after_offers + delivery_charge).floor(2)
  end
end
