Rails.application.routes.draw do
  devise_for :users

  resources :fixtures

  root to: "home#index"
end
