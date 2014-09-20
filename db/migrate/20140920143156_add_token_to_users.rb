class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    User.all.each do |u|
      u.update_column(token: SecureRandom::urlsafe_base64 ) 
    end
  end
end
