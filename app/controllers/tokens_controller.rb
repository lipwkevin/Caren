class TokensController < ApplicationController

  def show

  end

  def forget_password
    Token.create(
      event:params[:event],
      target:params[:id],
      token:SecureRandom.hex(8)
    )
    @link = "123"
  end
end
