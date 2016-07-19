class CommentsMailer < ApplicationMailer


  def notify_post_owner(comment)
    @comment = comment
    @user = comment.user
    @blog = comment.post
    mail(to: @blog.user.email, subject: "#{@user.full_name} commented your post")
  end

  
end
