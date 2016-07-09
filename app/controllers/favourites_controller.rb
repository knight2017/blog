class FavouritesController < ApplicationController

def index
  @posts = current_user.fav_posts

end

def create
   @blog = Post.find params[:post_id]
   @l = Favourite.new(post: @blog, user: current_user)
  #  if l.save
  #  redirect_to @blog, notice: " liked"
  #  else
  #  redirect_to @blog, alert: "already liked"
  #  end
   respond_to do |format|
    if @l.save
      format.html { redirect_to @blog, notice: "Faved"}
      format.js { render :create_success }
    else
      format.html { redirect_to @blog, alert: "already Faved"}
      format.js { render :create_failure }
    end
  end
end

def destroy
  @blog = Post.find params[:post_id]
  @l = Favourite.find params[:id]
  @l.destroy # if can? destroy Favourite
  respond_to do |format|
    format.html { redirect_to @blog}
    format.js { render }
  end
end


end
