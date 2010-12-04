Reads::Application.routes.draw do
  resources :feed_items
  resources :feeds do
    resources :feed_items
  end
  
  resources :reader_users
  devise_for :users
  
  root :to => "feeds#index"  
  
  match '/refresh_feed/:feed_id' => 'feed_items#refresh', :as => 'refresh'
  match '/delete_all_items/:feed_id' => 'feed_items#delete_all_items', :as => 'delete_all_items'
  match '/about' =>'feeds#about', :as=>'about'
  match '/subfeed/:id/:thread_id' => 'feeds#show', :as => 'subfeed'

end
