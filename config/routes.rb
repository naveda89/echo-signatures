Rails.application.routes.draw do

  resources :signatures, only: [:create],
            defaults: {format: 'json'}

  root 'main#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
