# frozen_string_literal: true

class DeliveryChargeRule
  def initialize(rules)
    @rules = rules.sort_by { |threshold, _| threshold }
  end

  def apply(subtotal, _items)
    rule = @rules.find { |threshold, _| subtotal < threshold }

    rule ? rule.last : 0
  end
end
