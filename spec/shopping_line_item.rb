require_relative '../lib/item'
require_relative '../lib/discount_able'
require_relative '../lib/shopping_line_item';
require "minitest/autorun"

describe ShoppingLineItem do
  before do
    item_params = {
      name: '羽毛球',
      unit: '个',
      unit_price: 1.00,
      category: nil,
      code: 'ITEM000001'
    }
    @item = Item.new item_params
  end

  describe "create line item" do
    it "should create with item and quantity" do
      quantity = 1
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.item.must_equal @item
      line_item.quantity.must_equal quantity
    end
  end

  describe "#total_price" do
    it "should work" do
      quantity = 1
      total_price = @item.unit_price * quantity
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.total_price.must_equal total_price
    end
  end

  describe "#discounted_price" do
    it "should work with no_discount" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:no_discount]
      quantity = 1
      discounted_price = @item.unit_price * quantity
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.discounted_price.must_equal discounted_price
    end

    it "should work with nice_five discount" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:nine_five_discount]
      quantity = 1
      discounted_price = @item.unit_price * quantity * 0.95
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.discounted_price.must_equal discounted_price
    end

    it "should work with buy_two_free_one discount" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:buy_two_free_one]
      quantity = 4
      discounted_price = @item.unit_price * (quantity-1)
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.discounted_price.must_equal discounted_price
    end

    it "should work with buy_two_free_one discount and quantity equal 2" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:buy_two_free_one]
      quantity = 2
      discounted_price = @item.unit_price * quantity
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.discounted_price.must_equal discounted_price
    end

    it "should work with buy_two_free_one discount and quantity equal 1" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:buy_two_free_one]
      quantity = 1
      discounted_price = @item.unit_price * quantity
      line_item = ShoppingLineItem.new(@item, quantity)
      line_item.discounted_price.must_equal discounted_price
    end
  end

  describe "#to_s" do
    it "should print with format" do
      @item.discount_type = DiscountAble::DISCOUNT_TYPES[:buy_two_free_one]
      quantity = 3
      line_item = ShoppingLineItem.new(@item, quantity)
      discounted_price = @item.unit_price * (quantity-1)
      print_message = "名称：#{@item.name}, 数量：#{line_item.quantity}#{@item.unit}, 单价：#{@item.unit_price}(元)，小计：#{discounted_price}(元)"
      line_item.to_s.must_equal print_message
    end
  end
end
