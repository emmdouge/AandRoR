Rails.application.routes.draw do
  
  # assign a named route to a static file by passing any non-empty string as :controller 
  # assuming you have a public/index.html, this is what will be served
  # root :controller => 'static', :action => '/public/index.html' 
  root to: 'static#index'

  get 'users/new'
  get '/users/:id' => 'users#show'
  
  # Added http://localhost:3000/users/auth/google_oauth2 as redirect url in google application
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
