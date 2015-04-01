Dashtag::Engine.routes.draw do
  root 'feed#index'
  get '/get_older_posts' => 'feed#get_older_posts', as: :get_older_posts
  get '/get_new_posts' => 'feed#get_new_posts', as: :get_new_posts
end
