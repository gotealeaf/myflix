class ChangeInvitationColumnNameToFullName < ActiveRecord::Migration
  def change
    rename_column :invitations, :name, :full_name
  end
end
