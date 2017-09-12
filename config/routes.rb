Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top_pages#index"
  resources :law_firms, only: :show

  namespace :admin do
    root "home_page#index"
    resources :lawyer_profiles, only: [:index, :update]
    resources :law_firms, only: [:index, :update]
  end

  namespace :user do
    root "questions#index"
    resources :accounts, except: [:new, :create, :delete]
    resources :questions
    resources :articles
    namespace :register_lawyer do
      resources :lawyer_profiles, only: [:new, :create, :update]
    end
  end

  namespace :lawyer do
    root "user/accounts#index"
    resources :lawyer_profiles, except: [:new, :create, :delete]
    resources :accounts, except: [:new, :create, :delete]
    resources :law_firms, except: [:show, :delete]
  end
end
