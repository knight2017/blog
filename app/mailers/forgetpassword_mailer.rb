class ForgetpasswordMailer < ApplicationMailer

  def forgetpassword(token)
    @user = User.where("reset_token LIKE '%#{token}%'").first
    mail(to: @user.email, subject: "#{@user.full_name} Please reset your password!")
  end

end
