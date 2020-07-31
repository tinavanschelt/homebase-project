Rails.application.routes.draw do
  root to: "pages#dashboard"

  devise_for :users

  get "/sandbox", to: "sandbox#index"
end
