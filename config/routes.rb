Rails.application.routes.draw do
  get 'logout' => 'tops#logout'
  post 'login' => 'tops#login'
  get 'users/home' => 'users#attendance'
  post 'tops/new' => 'tops#new'
  # get 'tops/login'
  get '/' => 'tops#top'
end
