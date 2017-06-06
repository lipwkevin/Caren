class AppMailer < ApplicationMailer
  default from: 'Caren Support'
  def reset_password(user,token)
    @user = user
    @link = token
    mail(to: @user.email, subject: "Reset Password")
  end
end
