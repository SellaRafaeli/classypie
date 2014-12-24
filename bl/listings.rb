$listings = $mongo.collection('listings')

module Listings
  extend self

  def create(params)
    id = $listings.add(params)  
  end
end
