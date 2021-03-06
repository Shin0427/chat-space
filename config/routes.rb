Rails.application.routes.draw do

  devise_for :users
  # root to: "messages#index"
  root to: 'groups#index'
  resources :users, only: [:index, :edit, :update]

  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]

    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
    

  end

    # URLがgroup/id/message/id にすることができる
  
end

