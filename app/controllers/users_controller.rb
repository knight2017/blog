class UsersController < ApplicationController

   def index
   end
   def show
     @user = User.find params[:id]
   end
   def edit
     @user = User.find params[:id]
   end

  def new
    @user = User.new
  end

  def create
        @user = User.new user_params
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path, notice: "User added"
        else
          render :new
        end
  end

  def update
    @user = User.find params[:id]
    if user_params[:current_password]
        if @user && @user.authenticate(user_params[:current_password])
          if user_params[:current_password] != user_params[:password]
             if @user.update(user_params)
               redirect_to root_path
             else
               render :edit
             end
          else
             flash[:alert] = "New Password must be different!"
             render :edit
          end
        else
          flash[:alert] = "Wrong Password"
          render :edit
        end
    else
      if @user.update(user_params)
       redirect_to root_path
      else
       render :show
      end
    end
  end

def resetpassword
   @user = User.where("reset_token ILIKE '%#{params[:token]}%'").first
   if user_params[:password] != '' && @user.update(user_params)
      session[:user_id] = @user.id
      session[:token]   = nil
      @user.reset_token = nil
      session[:count] = 0
      redirect_to user_path(@user)

   else
     redirect_to passwordreset_path(token: session[:token]), notice: "#{@user.errors.full_messages.join(", ")}"

   end

end

  # def passwordreset
  #   @user = User.where("reset_token LIKE '%#{params[:token]}%'")
  #   if @user
  #   else
  #     rende
  #
  # end

  def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end



end
