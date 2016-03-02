module CashMachine
  module DiscountTable
    class << self
      def refresh!(discounts=nil)
        discounts ||= default_discounts
        @discounts = discounts
      end

      def free_one_discount_items
        @discounts[:free_one] || []
      end

      def nine_five_discount_items
        @discounts[:nine_five_discount] || []
      end

      private

      def default_discounts
        {
          free_one: [],
          nine_five_discount: []
        }
      end
    end
    refresh!
  end
end
