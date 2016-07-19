    class PostsController < ApplicationController
        before_action :authenticate_user!,  except: [:show, :index]
        before_action :productowner, except: [:show, :index, :create, :new]


    def index
     params[:pgnum] ||= 0
     session[:pgnum]= params[:pgnum]
     @blogs2 = Post.all
     @blogs = Post.order(:id).offset(session[:pgnum].to_i*10).limit(10)
     a = Post.count
     a % 10 == 0 ? @numofpg = a/10 : @numofpg = a/10 + 1
     respond_to do |format|
       format.html { redner }
       format.json { render json: @blogs }
     end
    end
    def new
      @blog = Post.new
    end

    def create
         blog_new = params.require(:post).permit(:title, :image, :body, {tag_ids: []})
         @blog = Post.new blog_new
         @blog.user = current_user
         if @blog.save
           redirect_to post_path(@blog)
         else
           render :new
         end
    end

    def show
      @blog = Post.friendly.find params[:id]
      @comment = Comment.new
    end
    def edit
      @blog = Post.find params[:id]
    end

    def  update
      blog_update = params.require(:post).permit(:title, :image, :body, {tag_ids: []})
      @blog= Post.friendly.find params[:id]
      @blog.slug = nil
      if @blog.update(blog_update)
        redirect_to post_path(@blog)
      else
        render :edit
      end
    end

    def destroy
    @blog = Post.find params[:id]
    @blog.destroy
    redirect_to posts_path
    end
    def authenticate_user!
     redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
    end

   def productowner
     @blog  = Post.find params[:id]
     redirect_to root_path, alert: "access denied" unless can? :manage, @blog
  end
  def current_user_star
      @blog.star_for(current_user)
  end
  helper_method :current_user_star

end
