helpers do
  def em(text)
    "<em>#{text}</em>"
  end

  def t(word = nil)
    {}
    # {login: 'Login / Signup',
    #  logout: 'Logout'}
    # }
  end  

  def urlize(text)
    URI::encode(text.to_s.gsub(" ","-").gsub("%20","-"))
  end

  def link_for_user(user)
    "/user/#{user._id}" + (user.name ? "/#{urlize user.name}" : '')
  end

  def link_text_for_curr_user(user)
    user.email
    #user.name ? user.name : user.email
  end  

end