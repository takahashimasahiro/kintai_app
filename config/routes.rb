Rails.application.routes.draw do
  get '/' => 'sessions#new'
  patch 'reason' => 'holiday#add_reason'
  resources :sessions, :users, :attendances, :holidays, :user_managements, :attendance_to_csv
end
