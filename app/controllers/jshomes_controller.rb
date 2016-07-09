class JshomesController < ApplicationController
  def index
    render json: Post.all
  end

  def list
  end

  def show
    @blog = Post.find(params[:id])
    @comments = @blog.comments
    render json: @comments
  end
end
