Rails.application.routes.draw do
  devise_for :clients, path: 'clients', controllers: {
      sessions: 'clients/sessions'
  }
  devise_for :staffs, path: 'staffs', controllers: {
      sessions: 'staffs/sessions'
  }

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Client', at: 'client_auth'
      mount_devise_token_auth_for 'Staff', at: 'staff_auth'
    end
  end

  root "application#index"

  namespace :clients do
    resources :home, only: [:index] do
      get :user, on: :collection
    end
  end
  namespace :staffs do
    resources :home, only: [:index] do
      get :user, on: :collection
    end

    resources :clients, only: %i[index create]
    resources :forms, only: [:index]
    resources :organizations, only: %i[index create destroy]
  end

  get '/*slug', to: 'staffs/home#index'
end
