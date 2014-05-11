class ChangePasswordTokenToTokenForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :password_token, :token
  end
end
