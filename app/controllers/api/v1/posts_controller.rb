class Api::V1::QuestionsController < Api::BaseController
  DEFAULT_PER_PAGE = 7
  skip_before_action :authenticate_api_user
  def index
    @blogs = Post.order(created_at: :desc).page(params[:page]).per(params[:per] || DEFAULT_PER_PAGE)
  end

  def show
     blog = Post.find params[:id]
     blog_json = ActiveModelSerializers::SerializableResource.new(blog)
     render json: {blog: blog_json}
   end
end
