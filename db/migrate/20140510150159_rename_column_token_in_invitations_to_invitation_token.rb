class RenameColumnTokenInInvitationsToInvitationToken < ActiveRecord::Migration
  def change
    add_column :invitations, :invitation_token, :string
  end
end
