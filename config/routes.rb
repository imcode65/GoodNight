Rails.application.routes.draw do
  apipie

  get '/sleep_reports', to: 'sleeps#sleep_reports', as: :sleep_reports
  resources :sleeps, only: [:index, :show, :create, :update, :destroy]

  resources :users, only: [:index] do
    scope module: :users do
      get '/user_details', to: 'follows#user_details', as: :details
      resources :follows, only: [:create, :destroy]
    end
  end
end
