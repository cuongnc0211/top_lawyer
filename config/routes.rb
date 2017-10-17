Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top_pages#index"
  resources :law_firms, only: [:show, :index]
  resources :request_law_firms, only: [:new, :create]
  resources :questions, only: [:show, :index]

  namespace :admin do
    root "home_page#index"
    resources :lawyer_profiles, only: [:index, :update]
    resources :law_firms, only: [:index, :update]
    resources :accounts, only: [:index, :update]
    resources :articles, only: [:index, :destroy]
  end

  namespace :user do
    root "questions#index"
    resources :accounts, except: [:new, :create, :delete]
    resources :questions
    resources :votes, except: [:show, :new, :edit]
    namespace :register_lawyer do
      resources :lawyer_profiles, only: [:new, :create, :update]
    end
  end

  resources :articles do
    resources :comments, only: [:index, :create]
    get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  end

  resources :answers do
    resources :comments, only: [:index, :create]
    get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  end

  namespace :lawyer do
    root "accounts#show"
    resources :lawyer_profiles, except: [:new, :create, :delete]
    resources :accounts, except: [:new, :create, :delete]
    resources :law_firms, except: [:show, :delete]
    resources :request_law_firms, only: [:index, :destroy]
    resources :law_firm_members, only: [:index, :destroy]
    resources :add_law_firms, only: [:create, :index, :destroy]
    resources :out_law_firms, only: [:destroy]
    resources :articles
    resources :answers
    resources :questions, only: :index
    namespace :advertise do
      resources :history_advertises, only: [:new, :create]
    end
    resources :notifies, only: :index
  end

  namespace :search do
    root "top_pages#index"
    resources :top_pages, only: [:index]
  end
end
