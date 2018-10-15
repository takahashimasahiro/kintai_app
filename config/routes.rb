Rails.application.routes.draw do
  get 'users/home' => 'users#home'
  post 'users/show' => 'users#show'
  post 'users/save' => 'users#save'
  post 'sessions/new' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  get 'logout' => 'sessions#logout'
  post 'login' => 'sessions#login'
  get '/' => 'sessions#top'
end
