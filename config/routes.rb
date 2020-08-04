Rails.application.routes.draw do
  root to: "pages#dashboard"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :groups
  resources :group_members, only: [:create, :update]
  resources :invitations, only: [:create, :show, :update]

  get "/sandbox", to: "sandbox#index"
end
