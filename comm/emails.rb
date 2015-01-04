
module Email
  extend self

  def send(to, from, subj, body)
    send_opts(to: to, from: from, subject: subj, body: body)
  end

  def send_opts(params)    
      Pony.mail(params) #to, from, subject, body (text/erb)
  end
   
end