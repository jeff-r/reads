Rails.application.config.middleware.use OmniAuth::Builder do  

  # This adds the application's root path to the front of the paths 
  # that omniauth uses.
  # Thanks to http://stackoverflow.com/questions/4009892/rails-3-omniauth-and-passenger-throws-routingerror
  configure do |config|
    config.path_prefix = '/reads/auth' if RAILS_ENV == 'production'
  end


  provider :twitter, 'DwbVdpwtMql1MQJ3PECLw', 'hNPGkZf6Cj1ItQiMYRUr8OYe1v4QpiJwTkLZbaEB8c'  
  # provider :facebook, 'APP_ID', 'APP_SECRET'  
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  
