class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    User.all.each do |user|
      user.token = SecureRandom.urlsafe_base64
      user.save
    end
  end
end
