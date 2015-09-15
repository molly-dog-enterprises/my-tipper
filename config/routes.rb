Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :fixtures
  resources :picks
  resources :results do
    collection { get :leaderboard }
  end
  resources :team_wrappers
  resources :leagues

  resource :user do
    post :fixtures
  end

  root to: "home#index"
end
