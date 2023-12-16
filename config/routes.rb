Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :members, only:[:show]
end
