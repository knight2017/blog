class HomeController < ApplicationController
def index
session[:word] = params[:word]
perpg = 10
params[:pgnum] ||= 0
session[:pgnum] = params[:pgnum]
postn = Post.search(session[:word])
@posts = Post.search(session[:word]).order(:id).offset(perpg*params[:pgnum].to_i).limit(perpg)
postn.length%perpg == 0 ? @numofpg = postn.length/perpg  : @numofpg = postn.length/perpg + 1
end

def about
end
def password
end

  def token
    user = User.find_by_email params[:email]
    email1 = params[:email]
    if user && user.email == email1
       user.reset_token = SecureRandom.urlsafe_base64
       user.save
       @token = user.reset_token
       session[:token] = user.reset_token
       render :password
    else
       flash[:alert] = "email not found"
       render :password
    end
  end

  def passwordreset
     @user = User.where("reset_token LIKE '%#{params[:token]}%'").first
     if @user
        # render json: params
     else
       flash[:alert] = "invalid link"
       render :password
     end
  end









end
