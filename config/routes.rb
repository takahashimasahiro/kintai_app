Rails.application.routes.draw do
  get '/' => 'sessions#new'
  patch 'user_managements/paid/:id' => 'user_managements#update_all'

  resources :sessions, :users, :attendances, :holidays,
            :user_holiday, :user_managements, :attendance_to_csv, :operation_log

  namespace :api do
    resources :attends
  end
end
