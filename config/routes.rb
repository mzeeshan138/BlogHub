Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    get "dashboard", to: "dashboard#show", as: :dashboard
    resources :users, only: %i[index show edit update destroy]
    get "posts", to: "/posts#manage", as: :posts
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    member { patch :toggle_published }
    resources :comments, only: %i[create destroy]
  end

  resources :articles
  resources :article_comments
  resources :groups
  resources :user_groups
  resources :likes
  resources :attachments

  root "posts#index"

  constraints ->(request) { !request.path.start_with?("/rails/active_storage/") } do
    match "*unmatched_route", to: "errors#not_found", via: :all
  end
end
