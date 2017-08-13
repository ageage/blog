class PostsController < ApplicationController

  def index
    @posts = Post.common.order(posted_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end

  def tags
    if view_context.parameter_tag_list.present?
      @posts = Post.common
                   .order(posted_at: :desc)
                   .page(params[:page])
                   .tagged_with(view_context.parameter_tag_list, any: true)
      render :index
    else
      redirect_to action: 'index'
    end
  end
end
