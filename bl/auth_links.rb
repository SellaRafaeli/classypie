$auth_links = $mongo.collection('auth_link')

#$auth_links.index_information
$auth_links.ensure_index(:email)
$auth_links.ensure_index(:guid)
#$auth_links.ensure_index({ created_at: Mongo::ASCENDING }, { expireAfterSeconds: 5 } )

module AuthLinks
  extend self

  def guid
    SecureRandom.uuid + '-' + SecureRandom.uuid
  end

  # def create(email)
  #   data = {email: email, guid: guid}
  #   $auth_links.add(data)  
  # end

  def get_guid(email)
    fields = {guid: guid}
    $auth_links.update({email: email}, {'$set' => fields}, {upsert: true})   
    return guid
  end

  def get_by_email_and_guid(email,guid)
    $auth_links.get({email: email, guid: guid})
  end

end
