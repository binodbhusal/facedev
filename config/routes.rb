Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations' 
  }
  root 'home#index'
  resources :members, only:[:show]
  get 'edit_description', to: 'members#edit_description', as:'edit_user_description'
  patch 'update_description', to: 'members#update_description', as:'update_user_description'
  
  get 'edit_personal_details', to: 'members#edit_personal_details', as:'edit_user_personal_details'
  patch 'update_personal_details', to: 'members#update_personal_details', as:'update_user_personal_details'
  get 'member-connections/:id', to: 'members#connections', as:'member_connections'
  resources :work_experiences
  resources :connections
end
