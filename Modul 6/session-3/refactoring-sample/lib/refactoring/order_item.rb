module Refactoring
  class OrderItem
    attr_reader :item, :quantity

    def initialize(item,quantity)
      @item = item
      @quantity = quantity
    end

    def rate(voucher)
      if @quantity > 10
        0.8
      elsif @quantity > 5
        0.9
      elsif @quantity > 2
        0.95
      else
        
    end

    def price
      order_item.quantity * order_item.get_price
    end
  end
end
