require_relative '../../cash_machine/item'
require "minitest/autorun"

describe CashMachine::Item do
  before do
    @item_params = {
      name: '羽毛球',
      unit: '个',
      unit_price: 1.00,
      category: nil,
      code: 'ITEM000001'
    }
  end

  describe "create item" do
    it "should create item with params" do
      item = CashMachine::Item.new(@item_params)
      item.name.must_equal  @item_params[:name]
      item.unit.must_equal  @item_params[:unit]
      item.unit_price.must_equal  @item_params[:unit_price]
      item.category.must_equal  @item_params[:category]
      item.code.must_equal  @item_params[:code]
    end
  end
end
