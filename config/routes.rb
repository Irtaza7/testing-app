
Rails.application.routes.draw do

  devise_for :users

  resources :welcome do 
    collection do
      post :import
    end
  end

  resources :articles do
    resources :comments, only: [:create]
    resources :ratings, only: [:create]
    member do
      delete :purge_image
    end
  end

  root 'articles#index'
 end
 