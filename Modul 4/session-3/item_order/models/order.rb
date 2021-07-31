require './db/db_connector'

class Order 
  attr_accessor :reference_no, :customer_name, :date

  def initialize(param)
    @reference_no = param[:reference_no ]
    @customer_name = param[:customer_name]
    @date = param[:date]
    @items = []
  end

  def self.find_all
    client = create_db_client
    rawData = client.query("select * from orders")
    orders = Array.new
    rawData.each do |order|
      orders.push(Order.new(order["reference_no"], order["customer_name"], order["date"]))
    end
    orders
  end

  def self.find_by_reference_no(reference_no)
    client = create_db_client
    result = client.query("SELECT * FROM orders WHERE reference_no = #{@reference_no}")
    return nil unless result.count > 0
    data = result.first
    Order.new(data["reference_no"],data["customer_name"],data["date"])
  end

  def self.find_by_reference_no_with_items(reference_no)
    order = find_by_reference_no(reference_no)
    items = Item.find_by_order(order)
    order.items = items
    order
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query("
      INSERT INTO orders(reference_no, customer_name, date)
      VALUES ('#{reference_no}','#{customer_name}', '#{date}')
      ")
  end

  def delete
    Item.delete_by_order(self)

  end

  def valid?
    return false if @reference_no.nil?
    return false if @customer_name.nil?
    return false if @date.nil?
    true
  end

end
