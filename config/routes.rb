Rails.application.routes.draw do
  root to: "pages#dashboard"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :groups
  resources :group_members, only: [:create, :update]
  put "toggle_member_status", to: "group_members#toggle_status"
  resources :invitations

  resources :events
  resources :tasks
  put "toggle_task_complete", to: "tasks#toggle_complete"


  get "/sandbox", to: "sandbox#index"
end
