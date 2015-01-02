$users = $mongo.collection('users')

SETTABLE_USER_FIELDS = [:name, :desc, :img, :phone, :email, :fb_page, :website,]

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

  ## 

  def page_for(params)
    data = {target_user: Users.get(params.id)}
    erb :user, layout: :layout, locals: params
  end

end
