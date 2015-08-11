Dashtag::Engine.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'users/new'
  post 'users/create'

  get 'settings/edit'
  post 'settings/update'

  root 'feed#index'
  get '/get_older_posts' => 'feed#get_older_posts', as: :get_older_posts
  get '/get_new_posts' => 'feed#get_new_posts', as: :get_new_posts
end
