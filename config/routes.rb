Rails.application.routes.draw do
  resources :sleeps, only: [:index, :show, :create, :update, :destroy]
end
