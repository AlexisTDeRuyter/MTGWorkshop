Rails.application.routes.draw do
  get 'welcome/index'

  get 'profile', to: 'users#show'

  devise_for :users

  resources :decks, only: [:create, :show, :destroy] do
    resources :decklists, only: [:create, :destroy]
  end

  resources :cards, only: [:create, :destroy]

  resources :card_types, only: [:show]

  root 'welcome#index'
end
