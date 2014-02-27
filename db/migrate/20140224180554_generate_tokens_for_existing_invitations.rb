class GenerateTokensForExistingInvitations < ActiveRecord::Migration
  def change
  	Invitation.all.each do |invitation|
  		invitation.update_column(:token, SecureRandom.urlsafe_base64)
  	end
  end
end
