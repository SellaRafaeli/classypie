$users = $mongo.collection('users')

module Users
  extend self

  def create(params)
    $users.add(params)  
  end

end
