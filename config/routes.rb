Rails.application.routes.draw do
<<<<<<< HEAD
<<<<<<< HEAD
  get 'logout' => 'tops#logout'
=======
  get 'logout' => 'tops#logout'  
>>>>>>> 必要ファイルの追加
=======
  get 'logout' => 'tops#logout'
>>>>>>> 10月5日分
  post 'login' => 'tops#login'
  get 'users/home' => 'users#attendance'
  post 'tops/new' => 'tops#new'
  # get 'tops/login'
  get '/' => 'tops#top'
end
