Rails.application.routes.draw do
  resources :tasks
  resources :events
  root to: "pages#dashboard"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :groups
  resources :group_members, only: [:create, :update]
  put "toggle_member_status", to: "group_members#toggle_status"
  resources :invitations

  get "/sandbox", to: "sandbox#index"
end
