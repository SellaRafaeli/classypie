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
require './middleware/middleware_incoming'
require './middleware/middleware_outgoing'
require './middleware/error_handling.rb'
require './db/mongo'
#require './listings/'
require './bl/listings.rb'
require './users/user'
require './users/users_api'

get '/' do 
  erb :index, layout: :layout
end

get '/listing/:id/?:name?' do
  @listing = $listings.get(params.id) || {}  
  erb :index, layout: :layout
end

get '/listing/num' do  

end

post '/listing/create_or_update' do 
  Listings.create_or_update(params)
end

get '/offers/:listingID' do
  [{name: 'Joe', contact: 'joe@company.biz'}, {name: 'Jane', contact: 'jane@help.com'},
    {name: 'Joe2', contact: 'joe@company.biz'}, {name: 'Jane2', contact: 'jane@help.com'},
    {name: 'Joe3', contact: 'joe@company.biz'}, {name: 'Jane3', contact: 'jane@help.com'},
    {name: 'Joe', contact: 'joe@company.biz'}, {name: 'Jane', contact: 'jane@help.com'},
    {name: 'Joe2', contact: 'joe@company.biz'}, {name: 'Jane2', contact: 'jane@help.com'},
    {name: 'Joe3', contact: 'joe@company.biz'}, {name: 'Jane3', contact: 'jane@help.com'}
    ].to_json
end

get '/user/:id/?:username?' do
  erb :user, layout: :layout
end

get '/search/:id/?:foo?' do 
  erb :search, layout: :layout
end 



get '/ping' do
	{msg: 'pong'}
end
	
puts "Ready to rock".light_red

