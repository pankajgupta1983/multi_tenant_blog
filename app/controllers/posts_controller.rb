# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = filtered_posts
  end

  def new
    @post = current_user.posts.build
  end

  def show
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.organization = current_organization

    if @post.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("posts", partial: "posts/post", locals: { post: @post }),
            turbo_stream.replace("new_post", partial: "posts/form", locals: { post: current_user.posts.build })
          ]
        end
        format.html { redirect_to posts_path, notice: 'Post created' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@post, partial: "posts/post", locals: { post: @post }) }
        format.html { redirect_to posts_path, notice: 'Post updated' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      format.html { redirect_to posts_path, notice: 'Post deleted' }
    end
  end

  private

  def set_post
    @post = current_organization.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end

  def filtered_posts
    posts = current_organization.posts
    posts = posts.published if params[:published] == "true"
    posts.order(created_at: :desc)
  end
end
