Dashtag::Engine.routes.draw do
  root 'feed#index'
  get '/get_next_page' => 'feed#get_next_page', as: :get_next_page
  get '/get_new_posts' => 'feed#get_new_posts', as: :get_new_posts
end
