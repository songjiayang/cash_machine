require 'json'

module CashMachine
  module ItemTable
    class << self
      def refresh!(items=nil)
        items ||= default_items
        @items = items
      end

      def all
        @items[:free_one] || []
      end

      def find(item_code)
        @items.find { |item| item.code == item_code }
      end

      private

      def default_items
        file_path = File.expand_path('../../data/items.json', __FILE__)
        JSON.parse(File.read(file_path)).map { |item_params|
          Item.new(item_params)
        }
      end
    end
    refresh!
  end

end
