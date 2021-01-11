Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: :create
    collection do
      get 'search'
      get 'incremental_search'
    end
    get 'comments/:id', to: 'comments#checked'
  end
  resources :users, only: :show
end
