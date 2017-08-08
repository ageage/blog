class TopController < ApplicationController
  def index
    @posts = Post.common.order(posted_at: :desc).page(params[:page])
  end
end
