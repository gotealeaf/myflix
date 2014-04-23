class AddColumnInviteTokenToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invite_token, :string
  end
end
