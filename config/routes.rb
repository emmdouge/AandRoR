Rails.application.routes.draw do
  
  # assign a named route to a static file by passing any non-empty string as :controller 
  # assuming you have a public/index.html, this is what will be served
  # root :controller => 'static', :action => '/public/index.html' 
  root :to => 'static#index'
  get '/', :to => redirect('/index.html')
  get 'home', :to => static('index.html')

  get 'js/app.js', :to => static('js/app.js')
  get 'js/shims.js', :to => static('js/shims.js')
  get 'css/main.css', :to => static('css/main.css')
  get 'assets/favicon/favicon-PROD.ico', :to => static('assets/favicon/favicon-PROD.ico')

  get 'users/new'
  get '/users/:id' => 'users#show'
  
  # Added http://localhost:3000/users/auth/google_oauth2 as redirect url in google application
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
