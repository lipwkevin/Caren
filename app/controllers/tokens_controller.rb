class TokensController < ApplicationController

  def show

  end

  def update_password

  end
  def forget_password
    key = nil
    loop do
      key = SecureRandom.hex(32)
      break unless Token.exists?(key: key)
    end

    Token.create(
      event:params[:event],
      target:params[:id],
      key:key
    )
  end
end
