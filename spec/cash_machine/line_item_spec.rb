require_relative '../../cash_machine/item'
require_relative '../../cash_machine/discount_table'
require_relative '../../cash_machine/discount_able'
require_relative '../../cash_machine/line_item'
require "minitest/autorun"

describe CashMachine::LineItem do
  before do
    item_params = {
      name: '羽毛球',
      unit: '个',
      unit_price: 1.00,
      category: nil,
      code: 'ITEM000001'
    }
    @item = CashMachine::Item.new item_params
  end

  describe "create LineItem" do
    it "should create item with item and quantity" do
      quantity = 1
      line_item = CashMachine::LineItem.new(@item, quantity)
      line_item.quantity.must_equal quantity
      line_item.item.must_equal @item
      line_item.free.must_equal nil
    end
  end

  describe "discount able" do
    before do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
    end

    it "free_one_discount? should be false" do
      CashMachine::DiscountTable.refresh!
      @line_item.free_one_discount?.must_equal false
    end

    it "free_one_discount? should be false" do
      CashMachine::DiscountTable.refresh!({free_one: [@line_item.item.code]})
      @line_item.free_one_discount?.must_equal false
    end

    it "free_one_discount? should be true" do
      CashMachine::DiscountTable.refresh!({free_one: [@line_item.item.code]})
      @line_item.quantity = 3
      @line_item.free_one_discount?.must_equal true
    end

    it "nine_five_discount? should be false" do
      CashMachine::DiscountTable.refresh!
      @line_item.nine_five_discount?.must_equal false
    end

    it "nine_five_discount? should be true" do
      CashMachine::DiscountTable.refresh!({nine_five_discount: [@line_item.item.code]})
      @line_item.nine_five_discount?.must_equal true
    end
  end

  describe "total_price" do
    it "should work" do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
      @line_item.total_price.must_equal @line_item.item.unit_price * quantity
    end
  end

  describe "total_price" do
    it "should work" do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
      @line_item.total_price.must_equal @line_item.item.unit_price * quantity
    end
  end

  describe "cost_total_price" do
    before do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
    end

    it "should work with no discount" do
      CashMachine::DiscountTable.refresh!
      @line_item.cost_total_price.must_equal @line_item.item.unit_price * @line_item.quantity
    end

    it "should work with free_one" do
      CashMachine::DiscountTable.refresh!({free_one: [@line_item.item.code]})
      @line_item.quantity = 3
      free_quantity = 1
      expect_price = @line_item.item.unit_price * 2
      @line_item.cost_total_price.must_equal expect_price
      @line_item.free.to_s.must_equal "名称：#{@line_item.item.name}，数量：#{free_quantity}#{@line_item.item.unit}"
    end

    it "should work with nine_five_discount" do
      CashMachine::DiscountTable.refresh!({nine_five_discount: [@line_item.item.code]})
      @line_item.cost_total_price.must_equal @line_item.item.unit_price * @line_item.quantity * 0.95
    end
  end

  describe "discounted_price" do
    before do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
    end

    it "should work with no discount" do
      CashMachine::DiscountTable.refresh!
      @line_item.discounted_price.must_equal 0
    end

    it "should work with free_one " do
      CashMachine::DiscountTable.refresh!({free_one: [@line_item.item.code]})
      @line_item.quantity = 3
      @line_item.discounted_price.must_equal 1
    end

    it "should work with nine_five_discount" do
      CashMachine::DiscountTable.refresh!({nine_five_discount: [@line_item.item.code]})
      @line_item.quantity = 1
      @line_item.discounted_price.must_equal 0.05
    end
  end

  describe "to_s" do
    before do
      quantity = 1
      @line_item = CashMachine::LineItem.new(@item, quantity)
    end

    it "should work with default message" do
      CashMachine::DiscountTable.refresh!
      @line_item.to_s.must_equal "名称：羽毛球，数量：1个，单价：1.0(元)，小计：1.0(元)"
    end

    it "should work with nine_five_discount" do
      CashMachine::DiscountTable.refresh!({nine_five_discount: [@line_item.item.code]})
      @line_item.to_s.must_equal "名称：羽毛球，数量：1个，单价：1.0(元)，小计：0.95(元)，节省0.05(元)"
    end
  end
end
