class TokensController < ApplicationController

  def show

  end

  def update_password
    
  end
  def forget_password
    Token.create(
      event:params[:event],
      target:params[:id],
      token:SecureRandom.hex(8)
    )
  end
end
