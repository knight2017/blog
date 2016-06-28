class StarsController < ApplicationController
  def create
  star = Star.new star_params
  star.user = current_user
  star.post = current_post
  if star.save
    redirect_to current_post, notice: "#{star_params[:ratings]}stars"
  else
    redirect_to current_post, alert: "Errors"
  end
  end

  def destroy
    star = Star.find params[:id]
     if star
       star.destroy
       redirect_to current_post, notice: "Star removed"
     else
       redirect_to current_post
     end
  end

  def update

  star = Star.find params[:id]
  if star
  star.update(star_params)
  redirect_to current_post, notice: "star changed to #{star_params[:ratings]}"
  else
    redirect_to current_post
  end
  end


  private

  def star_params
    params.require(:star).permit(:ratings)
  end




end
