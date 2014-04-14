class ChangeColumnNameInviterEmailToInviterId < ActiveRecord::Migration
  def change
    rename_column :invitations, :inviter_email, :inviter_id
    change_column :invitations, :inviter_id, :integer
  end
end
