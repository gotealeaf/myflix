class ChangeInvitationColumnNamesToMatchSolution < ActiveRecord::Migration
  def change
    rename_column :invitations, :full_name, :recipient_name
    rename_column :invitations, :email, :recipient_email
  end
end
