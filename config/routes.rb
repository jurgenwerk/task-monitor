# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      resources :users
      resources :app_monitors
      resources :tasks
      resources :task_instances do
        collection do
          post :start
          post :end
        end
      end
    end
  end
end

