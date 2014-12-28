$users = $mongo.collection('users')

SETTABLE_USER_FIELDS = [:name, :about_me, :fb_page, :website, :public_contact_details]

module Users
  extend self

  def create(params)
    $users.add(params)  
  end

  def get(id)
    $users.get(id)
  end

  def update(params)    
    fields = params.just(SETTABLE_USER_FIELDS)
    $users.update_id(params.user_id, fields)    
  end

end
