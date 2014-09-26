class AddTokenToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :token, :string
    Invitation.all.each do |i|
      i.update_column(token: SecureRandom::urlsafe_base64 )
    end
  end
end
