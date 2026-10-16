Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    member do
      patch :toggle_published
    end
  end

  resources :comments
  resources :articles
  resources :article_comments
  resources :users
  resources :groups
  resources :user_groups
  resources :likes
  resources :attachments

  root "posts#index"
end
