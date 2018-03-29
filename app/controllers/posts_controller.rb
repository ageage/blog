class PostsController < ApplicationController
  before_action :set_all_tags, only: [:index, :tags]

  def index
    @posts = Post.common.order(posted_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
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

  private

  def set_all_tags
    @all_tags = ActsAsTaggableOn::Tag.all.map { |tag| tag.name }
  end
end
