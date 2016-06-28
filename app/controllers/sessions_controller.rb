class SessionsController < ApplicationController

  def new
  end


def create
 user = User.find_by_email params[:email]
 session[:count] ||= 0
 if session[:count] < 3
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       session[:count] = 0
       redirect_to  root_path, notice: "hello"
     else
       session[:count] += 1
       render :new
     end
 else
   redirect_to '/passwordrequest'
 end

end

def destroy
  session[:user_id] = nil
  redirect_to root_path, notice: "signed out"
end

end
