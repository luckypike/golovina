class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  layout 'app'

  def index
    authorize Post
    @posts = Post.all
  end

  def show
    authorize @post

    respond_to :html, :json
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @post = Post.new(post_params)

    authorize @post

    if @post.save
      head :created, location: post_path(@post.id)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @post

    if @post.update(post_params)
      head :ok, location: post_path(@post.id)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params[:post][:image_ids] = JSON.parse(params[:post][:image_ids]) if params[:post][:image_ids].present? && params[:post][:image_ids].is_a?(String)
      params.require(:post).permit(:title, :text, image_ids: [], images_attributes: [:weight, :id])
    end
end
