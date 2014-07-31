class GeneratePasswordResetTokenForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_column(:password_reset_token, SecureRandom.urlsafe_base64)
    end
  end
end
