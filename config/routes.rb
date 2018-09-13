Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'sessions#signin'
  get '/signin' => 'sessions#signin'
  get '/signout' => 'sessions#destroy'
  post '/create-session' => 'sessions#create', as: :create_session
  get '/myposts' => 'posts#myposts'
  resources :users
  resources :posts
  resources :comments
end
