class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy toggle_published]

  def manage
    authorize Post, :manage?
    @posts = policy_scope(Post).includes(:user).order(created_at: :desc)
  end

  def index
    @posts = Post.where(published: true).order(created_at: :desc)
  end

  def show
    authorize @post
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @post = Post.new
    authorize @post
    load_users
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user unless current_user.admin?
    authorize @post

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      load_users
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
    load_users
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      load_users
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  def toggle_published
    authorize @post
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
    permitted_attributes = [:title, :description, :published]
    permitted_attributes << :user_id if current_user.admin?
    params.expect(post: permitted_attributes)
  end

  def load_users
    @users = User.order(:name)
  end
end
