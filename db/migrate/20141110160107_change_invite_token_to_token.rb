class ChangeInviteTokenToToken < ActiveRecord::Migration
  def change
    rename_column :invitations, :invite_token, :token
  end
end
