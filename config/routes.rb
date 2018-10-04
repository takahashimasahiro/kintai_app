Rails.application.routes.draw do
<<<<<<< HEAD
  get 'logout' => 'tops#logout'
=======
  get 'logout' => 'tops#logout'  
>>>>>>> 必要ファイルの追加
  post 'login' => 'tops#login'
  get 'users/home' => 'users#attendance'
  post 'tops/new' => 'tops#new'
  # get 'tops/login'
  get '/' => 'tops#top'
end
