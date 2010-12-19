Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'DwbVdpwtMql1MQJ3PECLw', 'hNPGkZf6Cj1ItQiMYRUr8OYe1v4QpiJwTkLZbaEB8c'  
  # provider :facebook, 'APP_ID', 'APP_SECRET'  
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  
