$reviews = $mongo.collection('reviews')

SETTABLE_REVIEW_FIELDS = [:name, :about_me, :fb_page, :website, :public_contact_details]

module Reviews
  extend self

  def create(params)
    $reviews.add(params)  
  end

  def get(id, field)
    $reviews.get(id, field)
  end

  def find_all(params)
    $reviews.find_all(params)
  end

  def update(params)    
    fields = params.just(SETTABLE_REVIEW_FIELDS)
    $reviews.update_id(params.user_id, fields)    
  end

  ## 
  def of_target(user_id) 
    reviews = Reviews.find_all(target_id: user_id)
    reviews.map! {|rev| 
      rev.poster = $users.find({_id: rev.poster_id}, {fields: ['name']}).to_a[0]; 
      rev   
    }
  end

end
