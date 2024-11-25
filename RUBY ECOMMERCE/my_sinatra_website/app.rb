require 'sinatra'
require 'sinatra/reloader' # Automatically reload code during development

# In-memory product catalog
PRODUCTS = [
  { id: 1, name: 'Laptop', price: 1200 },
  { id: 2, name: 'Smartphone', price: 800 },
  { id: 3, name: 'Headphones', price: 150 }
]

# Cart to hold items (in-memory storage)
CART = []

# Home route
get '/' do
  erb :index, locals: { products: PRODUCTS }
end

# Add to cart
post '/cart/add/:id' do
  product = PRODUCTS.find { |p| p[:id] == params[:id].to_i }
  CART << product if product
  redirect '/'
end

# View cart
get '/cart' do
  erb :cart, locals: { cart: CART }
end

# Checkout
get '/checkout' do
  total = CART.sum { |item| item[:price] }
  erb :checkout, locals: { total: total }
end
