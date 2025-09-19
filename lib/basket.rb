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
end
