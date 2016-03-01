module CashMachine
  class LineItemsParser
    def self.parse(line_items)
      line_items.group_by { |line_item| line_item }.map do |k,v|
        if k.include? '-'
          item_code, quantity = k.split('-')
        else
          item_code = k
          quantity = v.count
        end
        item = ItemTable.find(item_code)
        [item, quantity.to_i]
      end
    end
  end
end
