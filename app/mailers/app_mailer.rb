class AppMailer < ApplicationMailer
  default from: 'from@example.com'
  layout 'mailer'


  def reset_password(user,token)
    @user = user
    @link = token
    mail(to: @user.email, subject: "Reset Password")
  end
end
