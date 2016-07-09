class CommentsController < ApplicationController
  before_action :authenticate_user!,  except: [:show, :index]
  before_action :productowner, except: [:show, :index, :create, :new]

  def comment_params
    params.require(:comment).permit(:body)
  end
  def create
    @blog = Post.find params[:post_id]
    @comment = @blog.comments.new comment_params
    @comment.user = current_user
    respond_to do |format|

        if @comment.save
          # CommentsMailer.notify_post_owner(@comment).deliver_now
          format.html {redirect_to post_path(@blog), notice: "comment Created"}
           format.js { render :create_success }
        else
          format.html {render "/posts/show"}
          format.js { render :create_failure }
        end
     end
  end


  def destroy
    post = Post.find params[:post_id]
    comment =  Comment.find params[:id]
    comment.destroy
    redirect_to post_path(post), notice: "deleted"
  end


  def authenticate_user!
       redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
     end

     def productowner
       @comment  = Comment.find params[:id]
       redirect_to post_path(id: @comment.post_id), alert: "access denied" unless can? :manage, @comment
    end





# def index
#   @comments = Comment.order(:id)
# end
#
#
# def new
#   @comment = Comment.new
# end
#
# def create
#
# params_new = params.require(:comment).permit(:body)
# @comment = Comment.new params_new
# if @comment.save
#   redirect_to comment_path(@comment)
# else
#   render :new
# end
# end
#
# def show
#   @comment = Comment.find params[:id]
# end
# def edit
#   @comment = Comment.find params[:id]
# end
#
# def update
#   @comment = Comment.find params[:id]
#   params_update = params.require(:comment).permit(:body)
#   if @comment.update(params_update)
#     redirect_to comment_path(@comment)
#   else
#     render :edit
#   end
# end
#
# def destroy
# @comment = Comment.find params[:id]
# @comment.destroy
# redirect_to comments_path
# end





end
