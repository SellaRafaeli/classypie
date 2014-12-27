$messages = $mongo.collection('messages')

module Messages
  extend self

  def create(params)
    data = params.merge!({created_at: Time.now})
    id = $messages.add(data)._id    
  end

  def by_offer(offer_id)
    $messages.find_all(offer_id: offer_id).to_a
  end

end
