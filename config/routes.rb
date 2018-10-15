Rails.application.routes.draw do
  get 'sessions/new'
  get 'logout' => 'session#logout'
  post 'login' => 'session#login'
  get 'users/home' => 'users#attendance'
  post 'users/show' => 'users#attendande_table'
  post 'tops/new' => 'session#new'
  post 'tops/create' => 'session#create'
  # get 'tops/login'
  get '/' => 'tops#top'
end
