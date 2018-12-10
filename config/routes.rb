Rails.application.routes.draw do
  get '/' => 'sessions#new'
  resources :sessions, :users, :attendances, :holidays, :user_managements, :attendance_to_csv
end
