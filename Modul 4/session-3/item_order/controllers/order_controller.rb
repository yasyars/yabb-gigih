require './models/order'

class OrderController

  def list_orders
    orders = Order.get_all_orders
    renderer = ERB.new(File.read("./views/index.erb"))
    renderer.result(binding)
  end

  def create_order(params)
    order = Order.new({
      reference_no: params['ref_no'],
      customer_name: params['cust_name'],
      date: params['date']
    })

    order.save
    renderer = ERB.new(File.read("./views/order.erb"))
    renderer.result(binding)
    
  end

  def create_order_form
    renderer = ERB.new(File.read("./views/create_order.erb"))
    renderer.result(binding)
  end
end