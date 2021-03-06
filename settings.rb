# The following are exposed globally via settings.key_name.
set :raise_errors,    false
set :show_exceptions, false

set :sessions,        true 
set :session_secret,  'eric_clapton'

set :public_folder,   File.dirname(__FILE__) + '/public'
set :views,           File.dirname(__FILE__) + '/public/views'
set :my_key,          'my_val' # settings.my_key == 'my_val'

configure do
  mime_type :erb, 'text/html'
end

# The following are exposed globally via $varname.
$app_name   = 'classyPie1'
$prod       = settings.production?
$root_url   = 'http://localhost:9292'
