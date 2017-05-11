Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: [:destroy] #экшена destroy не будет
  resources :questions

  get 'show' => 'users#show'
end
