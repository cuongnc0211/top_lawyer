Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top_pages#index"

  namespace :admin do
  end

  namespace :user do
    resources :accounts, except: [:new, :create, :delete]
    resources :questions
  end

  resources :articles do
    resources :comments, only: [:index, :create]
    get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  end

  namespace :lawyer do
    resources :lawyer_profiles, except: [:new, :create, :delete]
  end
end
