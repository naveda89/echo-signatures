Rails.application.routes.draw do

  resources :signatures, only: [:create],
            defaults: {format: 'json'}

  root 'main#index'

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

end
