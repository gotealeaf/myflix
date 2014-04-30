class AddTokensToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :token, :string
    Invitation.all.each do |invitation|
      invitation.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
