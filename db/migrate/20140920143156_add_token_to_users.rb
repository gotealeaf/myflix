class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    # If wanted to preseed token, this can do it
    # User.all.each do |u|
    #   u.token = SecureRandom::urlsafe_base64
    #   u.save
    # end
  end
end
