module CashMachine
  module DiscountAble
    def free_one_discount?
      self.quantity > 2 && DiscountTable.free_one_discount_items.include?(self.item.code)
    end

    def nice_five_discount?
      DiscountTable.nice_five_discount_items.include?(self.item.code)
    end
  end
end
