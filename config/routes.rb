Rails.application.routes.draw do
  devise_for :users

  get "manage/posts", to: "posts#manage", as: :manage_posts

  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    member do
      patch :toggle_published
    end

    resources :comments, only: %i[create destroy]
  end

  resources :articles
  resources :article_comments
  resources :users
  resources :groups
  resources :user_groups
  resources :likes
  resources :attachments

  root "posts#index"
end
