Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords'
  }

  # Routes for authenticated users
  authenticate :user do
    resources :departments
    resources :employees
    resources :bills do
      member do
        patch :approve
        patch :decline
      end
    end
    root 'bills#index', as: :authenticated_root
  end

  # Routes for unauthenticated users
  root 'home#index'
end
