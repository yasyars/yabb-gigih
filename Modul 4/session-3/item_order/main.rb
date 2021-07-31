require 'sinatra'
require './controllers/order_controller.rb'

get '/' do
  controller = OrderController.new
  controller.list_orders
end

get  'order/new' do
  controller = OrderController.new
  controller.create_order_form
end

post  '/order' do
  controller = OrderController.new
  controller.create_order(params)
end

get '/order' do
  controller = OrderController.new
  controller.create_order(params)
end

post '/order/edit/:ref_no' do
  controller = OrderController.new
  controller.edit_order(params)
end

get '/order/delete/:ref_no' do
  controller = OrderController.new
  controller.delete_order(params)
end

