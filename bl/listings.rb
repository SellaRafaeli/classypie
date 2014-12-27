$listings = $mongo.collection('listings')

module Listings
  extend self

  def create(params)
    data = params.merge!({created_at: Time.now, updated_at: Time.now, num_views: 0})
    id = $listings.add(data)._id
    url_title = URI::encode(data.title.gsub(" ","-"))
    {id: id, url_title: url_title}
  end

  def get(id)
    $listings.get(id)
  end
end
