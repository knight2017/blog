class FavouritesController < ApplicationController

def index
  @posts = current_user.fav_posts

end

def create
   @post = Post.find params[:post_id]
   l = Favourite.new(post: @post, user: current_user)
   if l.save
   redirect_to @post, notice: " liked"
   else
   redirect_to @post, alert: "already liked"
   end
end

def destroy
  post = Post.find params[:post_id]
  l = Favourite.find params[:id]
  l.destroy # if can? destroy Favourite
  redirect_to post
end


end
