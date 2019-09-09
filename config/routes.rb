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
    resources :home, only: [:index]
  end
  namespace :staffs do
    resources :home, only: [:index]
  end
end