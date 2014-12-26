$offers = $mongo.collection('offers')

module Offers
  extend self

  def create(params)
    id = $offers.add(params)._id
  end

  def by_listing(id)
    $offers.find_all(listing_id: id).to_a
  end
end
