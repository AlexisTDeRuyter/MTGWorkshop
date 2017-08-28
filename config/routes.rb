Rails.application.routes.draw do
  get 'welcome/index'

  get 'profile', to: 'users#show'

  devise_for :users

  root 'welcome#index'
end
