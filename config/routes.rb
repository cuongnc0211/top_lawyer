Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top_pages#index"

  namespace :admin do
  end

  namespace :user do
    resources :accounts, except: [:new, :create, :delete]
  end

  namespace :lawyer do
    resources :lawyer_profiles, except: [:new, :create, :delete]
  end
end
