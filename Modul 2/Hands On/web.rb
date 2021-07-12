require 'sinatra'

items = [
  {name: "laptop", price: 1000},
  {name:"gelas", price:2000}
]

get '/items' do
  erb :item, locals: {
    items: items
  }
end

get '/home' do
  erb :form, locals: {
    
  }
end

post '/items' do
  name = params['name']
  price = params['price']
  items << {name: name, price: price}
  redirect '/items'
end
