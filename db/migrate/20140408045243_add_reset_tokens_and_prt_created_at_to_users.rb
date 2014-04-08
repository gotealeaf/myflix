class AddResetTokensAndPrtCreatedAtToUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_columns(password_reset_token: SecureRandom.urlsafe_base64,
                          prt_created_at: 1.day.ago )
    end
  end
end
