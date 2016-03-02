module CashMachine
  module DiscountAble
    def free_one_discount?
      self.quantity > 2 && DiscountTable.free_one_discount_items.include?(self.item.code)
    end

    def nine_five_discount?
      DiscountTable.nine_five_discount_items.include?(self.item.code)
    end
  end
end
