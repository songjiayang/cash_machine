module CashMachine
  class LineItem
    class Free
      def initialize(item, quantity)
        @item = item
        @quantity = quantity
      end

      def to_s
        "名称：#{@item.name}，数量：#{@quantity}#{@item.unit}"
      end
    end

    include DiscountAble
    attr_accessor :item, :quantity
    attr_reader :free

    def initialize(item, quantity)
      @item = item
      @quantity = quantity
      @free = nil
    end

    def total_price
      @total_price ||= (item.unit_price * quantity)
    end

    def cost_total_price
      @cost_total_price ||= if free_one_discount?
                              free_quantity = quantity / 3
                              @free = Free.new(item, free_quantity)
                              item.unit_price * (quantity - free_quantity)
                            elsif nine_five_discount?
                              total_price * 0.95
                            else
                              total_price
                            end
    end

    def discounted_price
      @discounted_price ||= (total_price - cost_total_price).round(2)
    end

    def to_s
      print_message = "名称：#{item.name}，数量：#{quantity}#{item.unit}，单价：#{item.unit_price}(元)，小计：#{cost_total_price}(元)"
      if nine_five_discount?
        print_message += "，节省#{discounted_price}(元)"
      end
      print_message
    end
  end
end
