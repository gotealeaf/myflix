class ChangeUsersTokenColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :password_reset_token, :token
  end
end
