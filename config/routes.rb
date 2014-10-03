Rails.application.routes.draw do

  resources :signatures, only: [:create],
            defaults: {format: 'json'} do
    collection do
      get :generator
    end
  end

  root 'main#index'

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

end
