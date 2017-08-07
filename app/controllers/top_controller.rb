class TopController < ApplicationController
  def index
    @posts = Post.all.order(:posted_at).page(params[:page])
  end
end
