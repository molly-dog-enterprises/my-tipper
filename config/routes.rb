Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :fixtures
  resources :picks
  resources :results
  resources :team_wrappers

  resource :user do
    post :fixtures
  end

  root to: "home#index"
end
