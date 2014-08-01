class AddMessageColumnToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :message, :string
  end
end
