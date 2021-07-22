require 'sinatra'
require_relative './model/item'
require_relative './model/category'


get '/' do
  items = Item.get_all_items
  erb :index, locals: {
    items: items
  }
end

get '/items/new' do 
  categories = Category.get_all_categories
  erb :create, locals: {
    categories: categories
  }
end

get '/items/:item_id/edit' do
  categories = Category.get_all_categories
  item_id = params['item_id']
  item = Item.find(item_id)
  erb :edit, locals: {
    categories: categories,
    item: item
  }
end

post '/items/create' do
  name = params['name']
  price= params['price']
  category_id= params['category_id']
  category = Category.find(category_id)
  item = Item.new(nil,name, price,category)
  item.insert_item_with_category
  redirect '/'
end

get '/items/:item_id' do 
  item_id = params['item_id']
  item = Item.find(item_id)
  erb :detail, locals: {
    item: item
  }
end

put '/items/:item_id' do
  item_id = params['item_id']
  name = params['name']
  price = params['price']
  category_id = params['category_id']
  category = Category.find(category_id)
  item = Item.find(item_id)
  item.update_item(name, price,category)
  redirect "/items/#{item_id}"
end

delete '/items/:item_id' do
  item_id = params['item_id']
  item = Item.find(item_id)
  item.delete
  redirect '/'
end