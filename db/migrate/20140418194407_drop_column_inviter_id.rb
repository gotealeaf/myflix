class DropColumnInviterId < ActiveRecord::Migration
  def change
    remove_column :invitations, :inviter_id
  end
end
