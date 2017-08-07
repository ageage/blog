class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(5)
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
end
