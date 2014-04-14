class AddColumnGuestNameAndInvitationMessage < ActiveRecord::Migration
  def change
    add_column :invitations, :guest_name, :string
    add_column :invitations, :message, :text
  end
end
