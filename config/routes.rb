Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  get 'posts/:post_id/comments/:id', to: 'posts#checked'
  resources :posts do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
