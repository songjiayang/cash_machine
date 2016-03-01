module CashMachine
  class Item
    attr_accessor :name,
                  :unit,
                  :unit_price,
                  :category,
                  :code

    def initialize(params)
      assign_attributes(params)
    end

    private

    def assign_attributes(params)
      params.each do |attribute, value|
        send "#{attribute}=", value
      end
    end
  end
end
