require './cash_machine/discount_table';
require './cash_machine/item';
require './cash_machine/item_table';
require './cash_machine/discount_able';
require './cash_machine/line_item';
require './cash_machine/line_items_parser';

module CashMachine
  def self.perform(line_item_codes)
    puts '***<没钱赚商店>购物清单***'
    line_items = LineItemsParser.parse(line_item_codes).map { |line_item| LineItem.new(*line_item) }
    line_items.each { |line_item| puts line_item.to_s }
    free_lines = line_items.map(&:free).compact
    if free_lines.any?
      puts '----------------------'
      puts '买二赠一商品：'
      free_lines.each { |free| puts free.to_s }
    end
    puts '----------------------'
    puts "总计：#{line_items.map(&:cost_total_price).reduce(&:+)}(元)"
    discounted_total_price = line_items.map(&:discounted_price).reduce(&:+)
    puts "节省：#{discounted_total_price}(元)" if discounted_total_price > 0
    puts '**********************'
  end
end
