require 'sinatra'
require_relative './db_connector'

get '/' do
  items = get_all_items
  erb :index, locals: {
    items: items
  }
end

get '/items/new' do 
  categories = get_all_categories
  erb :create, locals: {
    categories: categories
  }
end

get '/items/:item_id/edit' do
  categories = get_all_categories
  item_id = params['item_id']
  item = get_item_details(item_id)
  erb :edit, locals: {
    categories: categories,
    item: item
  }
end

post '/items/create' do
  name = params['name']
  price= params['price']
  category_id = params['category_id']
  insert_item_with_category(name,price,category_id)
  redirect '/'
end

get '/items/:item_id' do 
  item_id = params['item_id']
  item = get_item_details(item_id)
  erb :detail, locals: {
    item: item
  }
end

put '/items/:item_id' do
  item_id = params['item_id']
  name = params['name']
  price = params['price']
  category_id = params['category_id']
  update_item(item_id,name, price,category_id)
  redirect "/items/#{item_id}"
end

delete '/items/:item_id' do
  item_id = params['item_id']
  delete_item(item_id)
  redirect '/'
end