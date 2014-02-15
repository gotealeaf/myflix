class AddTokenToFriend < ActiveRecord::Migration
  def change
    add_column :friends, :token, :string
    Friend.all.each do |friend|
      friend.token = SecureRandom.urlsafe_base64
      friend.save
    end
  end
end
