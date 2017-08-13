class Admin::PostsController < Admin::ApplicationController

  def index
    @posts = Post.all.order(posted_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    p @post
  end

  def create
    @post = Post.new(post_params)
    @post.tag_list = params[:post][:tag_list]
    if params[:preview_button]
      render template: 'admin/posts/preview'
    elsif @post.save
      redirect_to [:admin, @post], notice: '投稿を作成しました。'
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    @post.tag_list = params[:post][:tag_list]
    if params[:preview_button]
      render template: 'admin/posts/preview'
    elsif @post.save
      redirect_to [:admin, @post], notice: '投稿を更新　しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :admin_posts, notice: '投稿を削除しました。'
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :posted_at, :status)
  end
end
