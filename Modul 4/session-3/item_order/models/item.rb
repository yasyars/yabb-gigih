class Item 

  def initialize(id, name, price, order)
    @id = id
    @name = name
    @price = price
    @order = order
  end

  def self.find_by_order(order)
    client = create_db_client
    result = client.query("SELECT * FROM items WHERE reference_no=#{order}")
  end

  def self.delete_by_order(order)

  end



end
