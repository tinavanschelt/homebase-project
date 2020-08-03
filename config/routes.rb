Rails.application.routes.draw do
  root to: "pages#dashboard"

  devise_for :users

  resources :groups
  resources :group_members, only: [:create, :update]
  resources :invitations, only: [:create, :update]

  get "/sandbox", to: "sandbox#index"
end
