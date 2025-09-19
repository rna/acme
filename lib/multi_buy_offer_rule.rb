# frozen_string_literal: true

# A generic rule implementation for "multi-buy" offers like "buy one, get one half price"
# This is a more extensible implementation of such offers in future
class MultiBuyOfferRule
  def initialize(product_code:, buy_quantity:, offer_quantity:, discount_percentage:, product_catalogue:)
    @product_code = product_code
    @buy_quantity = buy_quantity
    @offer_quantity = offer_quantity
    @discount_percentage = discount_percentage
    @product_catalogue = product_catalogue
  end

  def apply(_subtotal, items)
    count = items.count(@product_code)

    return 0 unless count >= @buy_quantity

    # For a "buy 2, get 1 free" on 5 items, it applies twice.
    num_of_applicable_items = count / @buy_quantity

    product_price = @product_catalogue[@product_code][:price]
    discount_per_item = product_price * @discount_percentage
    total_discount = num_of_applicable_items * @offer_quantity * discount_per_item

    # Return the discount as a negative value.
    -total_discount
  end
end
