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
# require './users/user'
# require './users/users_api'

def locals
  listing = params.listing_id ? Listings.get(params.listing_id) : {}
  target_user = params.target_user_id ? Users.get(params.target_user_id) : nil
  user    = (id = session.user_id) ? Users.get(id) : nil
  user_id = user && user._id
  
  {listing: listing, 
   target_user: target_user,
   user: user, 
   user_email: user && user.email, 
   user_id: user_id,
   is_owner: listing.user_id == user_id
  }
end

def user_ids
  {user_id: session.user_id}
end

def signup_if_new
  session.user_id = Users.create({email: params.contact})._id if !session.user_id 
end

post '/signup' do
  user         = Users.create(params)  
  session.user_id = user._id
end

get '/me' do
  Users.get(session.user_id)  
end

post '/logout' do
  session.user_id = nil
end

get '/' do 
  erb :index, layout: :layout, locals: locals
end

get '/modo' do 
  send_file File.join(settings.public_folder, 'modo.html')
end


get '/listing/:listing_id/?:name?' do  
  erb :index, layout: :layout, locals: locals
end

post '/listing/create' do 
  signup_if_new
  res = Listings.create(params.merge!(user_ids))
  res.id+'/'+res.url_title
end

post '/offers/create' do
  signup_if_new
  Offers.create(params.merge!(user_ids))
end

post '/offers/addMsg/:offer_id' do
  Messages.create(params.merge!(user_ids))
end

get '/user/:target_user_id/?:name?' do
  erb :user, layout: :layout, locals: locals
end

post '/user/:target_user_id/?:name?' do
  Users.update(params.merge!(user_ids))  
  erb :user, layout: :layout, locals: locals
end

post '/reviews/user/:target_user_id' do  
  params.poster_id = session.user_id
  Reviews.create(params.merge!(user_ids))
  erb :user, layout: :layout, locals: locals
end

get '/search/?:content?/?:location?' do 
  data = locals.merge(params)

  if params.content && params.location 
    params.lat, params.lng = Search.coordinates(params)
    data.listings = Listings.search(params.content,params.lat,params.lng)
  else
    data.listings = []
  end

  erb :search, layout: :layout, locals: data
end

get '/ping' do
	{msg: 'pong'}
end
	
puts "Ready to rock".light_red

