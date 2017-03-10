class RenameTokenToKeyFromTokens < ActiveRecord::Migration[5.0]
  def change
    rename_column :tokens, :token, :key
  end
end
