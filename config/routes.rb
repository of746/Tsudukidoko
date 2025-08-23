Rails.application.routes.draw do
  get 'stores/index'
  get 'seriesbooks/index'
  devise_for :users
  get 'users/index'
  root 'seriesbooks#index'
  devise_scope :user do
    post 'guest_sign_in', to: 'sessions#guest_sign_in'
  end
  resources :seriesbooks do
    get :search_books, on: :collection
    collection do
      get :search_books_new
    end
    resources :books, only: [:create, :edit, :update, :destroy]
    resources :books do
      collection do
        post :bulk_create
        post :bulk_delete
      end
    end
  end
  resources :stores, except: [:show]
end
