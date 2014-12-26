after do 
	if @response.body.is_a? Hash #return hashes as json
		content_type 'application/json'
    @response.body = @response.body.to_json		
	end

	set_cookie(UUID_COOKIE,  SecureRandom.uuid, expires: Time.now+60*60*24*365) if !cookies[UUID_COOKIE]
end

def set_cookie(key, value, opts = {})
	default_opts = {value: value,
									path: '/',
								  domain: ($prod ? request.host : ''), #localhost domain must be nil or browser won't save cookies.									
									httponly: true,
									expires: Time.now+60*60*4, 
									}

	final_opts = default_opts.merge!(opts)
	response.set_cookie key, final_opts	
end

def remove_cookie(key)	
	set_cookie(key, "deleted", expires: Time.now - 3600*30)
end

