class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :reset_password_email_sent_at, :datetime
  end
end
