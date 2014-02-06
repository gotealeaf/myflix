class AddFieldsToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :active, :boolean
    add_column :invitations, :token, :string
  end
end
