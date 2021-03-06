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
require './secret_config'
require './settings'
require './db/mongo'
require_all './bl'
require_all './middleware'
require_all './comm'


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
  if !session.user_id
    new_user = Users.create(params)
    res = (new_user == 'taken') ? 'taken' : session.user_id = new_user._id 
    return res
  end     
end

post '/signup' do
  email = params.email
  if Users.get({email: email })
    guid = AuthLinks.get_guid(email)
    Emails.send_entry_link(email, guid)
    return 'taken' 
  end

  user         =  Users.create(params)  
  session.user_id = user._id
  'ok'
end

get '/me' do
  Users.get(session.user_id)  
end

post '/logout' do
  session.clear
end

get '/' do 
  erb :index, layout: :layout, locals: locals
end

get '/auth_link' do
  email = params.email
  guid  = params.guid
  if authed_user = AuthLinks.get_by_email_and_guid(email, guid)
    user = Users.get_by_email(email)
    user_id = user._id
    session.user_id = user._id
    redirect to('/')
  else  
    erb :index, layout: :layout, locals: locals
  end
end

get '/listing/:listing_id/?:name?' do  
  erb :listing, layout: :layout, locals: locals
end

post '/listing/create' do 
  res = signup_if_new
  return res if res == 'taken' 
  res = Listings.create(params.merge!(user_ids))
  res.id+'/'+res.url_title
end

post '/listing/update/:id' do 
  res = Listings.update(params)
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
  signup_if_new
  params.poster_id = session.user_id
  Reviews.create(params.merge!(user_ids))  
end

get '/search/?:content?/?:location?' do 
  data = locals.merge(params)
  params.lat, params.lng = Search.coordinates(params) if params.location  
  
  data.listings = params.content ? Listings.search(params.content,params.lat,params.lng) : []
    
  erb :search, layout: :layout, locals: data
end

get '/ping' do
	{msg: 'pong'}
end	
#puts "Ready to rock".light_red