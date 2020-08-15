require 'sidekiq/web'

Rails.application.routes.draw do
  resources :lessons do
    resources :comments
  end
  
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  devise_for :users
  root to: 'home#index'
  resources :users, only: [:index]
  
  get '/home/about', to: 'home#about', as: 'about'
  get '/home/landing', to: 'home#landing', as: 'landing'
  get '/home/contact', to: 'home#contact', as: 'contact'
  post '/messages', to: 'messages#create', as: 'new_message'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
