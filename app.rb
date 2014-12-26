require 'rubygems'
require 'bundler'
require 'sinatra/namespace'
require 'sinatra/reloader' #dev-only
require 'active_support/core_ext/hash/slice'
require 'json' 
require 'erb'
require 'securerandom'

Bundler.require

# our app files - export to separate require.rb file when grows out of hand
require './lib/mylib'
require './settings'
require './db/mongo'
require_all './bl'
require_all './middleware'
require './users/user'
require './users/users_api'

def locals
  listing = $listings.get(params.id) || {}  
  user    = (id = session.user_id) ? $users.get(id) : nil
  
  {listing: listing, 
   user: user, 
   user_email: user && user.email, 
   user_id: user && user._id,
   uuid: cookies.uuid
  }
end

def user_ids
  {user_id: session.user_id, uuid: cookies.uuid}
end

post '/signup' do
  user         = $users.add(params)  
  session.user_id = user._id
end

get '/me' do
  $users.get(session.user_id)
end

post '/logout' do
  session.user_id = nil
end

get '/' do 
  erb :index, layout: :layout, locals: locals
end

get '/listing/:id/?:name?' do  
  erb :index, layout: :layout, locals: locals
end

post '/listing/create' do 
  res = Listings.create(params.merge!(user_ids))
  res.id+'/'+res.url_title
end

post '/offers/create' do
  Offers.create(params.merge!(user_ids))
end

# get '/offers/by_listing/:listing_id' do
#   Offers.by_listing(params.listing_id)
# end

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

