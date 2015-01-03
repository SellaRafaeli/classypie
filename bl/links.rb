module Links
  extend self

  def urlize(text)
    text = text.to_s
    URI::encode(text.gsub(" ","-").gsub("%20","-"))
  end

  def maybe(part)
    part ? "/#{urlize(part)}" : ''
  end

  def user(user_id, name = nil)
    "/user/#{user_id}" + maybe(name)
  end

end
