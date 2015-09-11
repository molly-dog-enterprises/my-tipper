Rails.application.routes.draw do
  devise_for :users

  resources :fixtures
  resources :picks

  resource :user do
    post :fixtures
  end

  root to: "home#index"
end
