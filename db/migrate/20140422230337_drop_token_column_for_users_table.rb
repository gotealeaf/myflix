class DropTokenColumnForUsersTable < ActiveRecord::Migration
  def up
    drop_table :token_column_for_users
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
