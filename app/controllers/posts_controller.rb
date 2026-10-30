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
    @comments = @post.comments.where(parent_comment_id: nil).includes(:user).order(created_at: :asc)
  end

  def new
    @post = Post.new(user: current_user)
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    if @post.save
      redirect_to admin_post_request? ? admin_posts_path : posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.user = current_user
    if @post.update(post_params)
      redirect_to admin_post_request? ? admin_post_path(@post) : post_path(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to admin_post_request? ? admin_posts_path : posts_path, notice: "Post was successfully deleted."
  end

  def toggle_published
    authorize @post
    @post.update!(published: !@post.published?)

    respond_to do |format|
      format.html { redirect_to admin_post_request? ? admin_post_path(@post) : post_path(@post), notice: "Post publication status updated." }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: [:title, :description, :published])
  end

  def admin_post_request?
    request.path.start_with?("/admin/posts")
  end
end
