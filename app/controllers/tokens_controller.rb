class TokensController < ApplicationController

  def show
    key = params[:key]
    token = Token.find_by(key:key)
    if token.nil?
      render :token_error
    elsif token.event==("PASSWORD")
      # session[:user_id] = token.target
      user = User.find(token.target)
      render :template => 'users/reset_password', :locals => {key:key,user:user}
    end

  end

  def forget_password_respond
    user = (User.find_by_uid_and_email(params[:uid],params[:email]))
    unless user.nil?
      key = nil
      loop do
        key = SecureRandom.hex(8)
        break unless Token.exists?(key: key)
      end

      Token.create(
        event:"PASSWORD",
        target:user.id,
        key:key
      )
      link = "#{ENV["DOMAIN"]}/token/#{key}"
      AppMailer.reset_password(user,link).deliver_now
      @email = user.email
      render "forget_password_success"
    else
      render "forget_password_fail"
    end

  end

  def forget_password
  end
end
