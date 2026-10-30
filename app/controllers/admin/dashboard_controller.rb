module Admin
  class DashboardController < ApplicationController
    def show
      authorize :dashboard, :show?

      @users_count = User.count
      @posts_count = Post.count
      @published_posts_count = Post.where(published: true).count
      @draft_posts_count = Post.where(published: false).count
      @recent_posts = Post.includes(:user).order(created_at: :desc).limit(5)
    end
  end
end
