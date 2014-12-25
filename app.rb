require 'rubygems'
require 'bundler'
require 'sinatra/namespace'
require 'sinatra/reloader' #dev-only
require 'active_support/core_ext/hash/slice'
require 'json' 
require 'erb'

Bundler.require

# our app files - export to separate require.rb file when grows out of hand
require './lib/mylib'
require './settings'
require './db/mongo'
require_all './bl'
require_all './middleware'
require './users/user'
require './users/users_api'



post '/signup' do
  user         = $users.add(params)  
  session.user_id = user._id
end

get '/me' do
  $users.get(session.user_id)
end

post '/logout' do
  session.clear
end

get '/' do 
  erb :index, layout: :layout
end

get '/listing/:id/?:name?' do
  @listing = $listings.get(params.id) || {}  
  erb :index, layout: :layout
end

post '/listing/create' do 
  Listings.create(params)
end

post '/offers/create' do
  Offers.create(params)
end

get '/offers/by_listing/:listing_id' do
  Offers.by_listing(params.listing_id)
end

# get '/user/:id/?:username?' do
#   erb :user, layout: :layout
# end

# get '/search/:id/?:foo?' do 
#   erb :search, layout: :layout
# end 

get '/ping' do
	{msg: 'pong'}
end
	
puts "Ready to rock".light_red

