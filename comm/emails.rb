
module Email
  extend self

  Pony.options = {  
    :from => 'classypieCEO@gmail.com', 
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'classypieceo',
      :password             => $sc.classypieceo_password,
      :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
      :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
    }
  }

  def send(to, subj, body)
    send_opts(to: to, subject: subj, html_body: body)
  end

  def send_opts(params)    
      Pony.mail(params) #to, from, subject, body (text/erb)
  end
   
  ##

  def send_entry_link(email, guid)
    link = "#{$root_url}/auth_link?email=#{email}&guid=#{guid}"
    send(email, '[ClassyPie ENTRY Link]', "Click the link to enter ClassyPie: <a href=\"#{link}\">#{link}</a>")
  end

end

Emails = Email #alias 