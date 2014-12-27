$users = $mongo.collection('users')

module Users
  extend self

  def create(params)
    $users.add(params)  
  end

  def get(id)
    $users.get(id)
  end

  def update(params)    
    fields = params.just(:name)
    $users.update_id(params.user_id, fields)    
  end

end
