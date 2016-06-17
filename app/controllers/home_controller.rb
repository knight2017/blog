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




end
