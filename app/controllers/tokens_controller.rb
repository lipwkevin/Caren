class TokensController < ApplicationController

  def show
    render :file => '/tokens/reset_password_respond.js.erb'
  end

  def forget_password
    Token.create(
      event:params[:event],
      target:params[:id],
      token:SecureRandom.hex(8)
    )
  end
end
