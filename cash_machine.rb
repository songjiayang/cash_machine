require './cash_machine/discount_table';
require './cash_machine/item';
require './cash_machine/item_table';
require './cash_machine/discount_able';
require './cash_machine/line_item';
require './cash_machine/line_items_parser';

module CashMachine
  class << self
    def perform(line_item_codes)
      puts '***<没钱赚商店>购物清单***'
      line_items = LineItemsParser.parse(line_item_codes).map { |line_item|
        LineItem.new(*line_item)
      }
      print_line_items_message(line_items)
      free_items = line_items.map(&:free).compact
      if free_items.any?
        puts '----------------------'
        puts '买二赠一商品：'
        print_free_items_message(free_items)
      end
      puts '----------------------'
      print_summary_message(line_items)
      puts '**********************'
    end

    private

      def print_line_items_message(line_items)
        line_items.each { |line_item| puts line_item }
      end

      def print_free_items_message(free_items)
        free_items.each { |free_item| puts free_item }
      end

      def print_summary_message(line_items)
        total_price = line_items.map(&:cost_total_price).reduce(&:+)
        puts ["总计：#{total_price}(元)"]
        discounted_total_price = line_items.map(&:discounted_price).reduce(&:+)
        puts "节省：#{discounted_total_price}(元)" if discounted_total_price > 0
      end
  end
end
