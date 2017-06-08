# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      resources :users
      resources :task_instances do
        collection do
          post :track
        end
      end
    end
  end
end
