class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy toggle_published]

  def index
    @posts = Post.where(published: true).order(created_at: :desc)
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @post = Post.new
    load_users
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      load_users
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_users
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      load_users
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  def toggle_published
    @post.update!(published: !@post.published?)

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Post publication status updated." }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: [:title, :description, :published, :user_id])
  end

  def load_users
    @users = User.order(:name)
  end
end
