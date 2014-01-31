class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_column(:token, SecureRandom.urlsafe_base64)
      user.save
    end
  end
end
