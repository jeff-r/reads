Reads::Application.routes.draw do
  resources :pages

  resources :settings


  match '/links/sortorder' => 'links#sortorder', :via => [:post, :get]
  resources :links

  root :to => "feeds#index"  

  match '/auth/:provider/callback' => 'authentications#create', :as => 'auth'
  resources :authentications

  resources :feed_items
  resources :feeds do
    resources :feed_items
  end
  
  resources :reader_users
  devise_for :users, :controllers => { :registrations => 'registrations' }
  
  
  match '/refresh_feed/:feed_id' => 'feed_items#refresh', :as => 'refresh'
  match '/delete_all_items/:feed_id' => 'feed_items#delete_all_items', :as => 'delete_all_items'
  match '/about' =>'feeds#about', :as=>'about'
  match '/subfeed/:id/:thread_id' => 'feeds#show', :as => 'subfeed'

  match '/trails/sortorder' => 'trails#sortorder', :via => [:post, :get]
  match '/trails/sort_trails_list' => 'trails#sort_trails_list', :via => [:post, :get]
  match '/trails/setcurrent/:trailid' => 'trails#setcurrent', :via => [:post, :get], :as => 'setcurrent'
  

  resources :trails
end
