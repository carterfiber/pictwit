Rails.application.routes.draw do
  get 'epicenter/feed'

  post 'epi_tweet' => 'epicenter#epi_tweet'

  get  'show_user' => 'epicenter#show_user'

  get 'now_following' => 'epicenter#now_following'

  get  'unfollow' => 'epicenter#unfollow'

  get 'tag_tweets' => 'epicenter#tag_tweets'
  
  root 'epicenter#feed'

  get 'all_users' => 'epicenter#all_users'

  get 'following' => 'epicenter#following'
  get 'followers' => 'epicenter#followers'



  resources :tweets
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
end
