class ChangeTableNamePasswordResets < ActiveRecord::Migration
  def change
    rename_table :password_resets, :user_tokens
  end
end
