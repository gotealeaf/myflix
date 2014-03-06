class ChangeUserEmailAddressColumnToEmail < ActiveRecord::Migration
  def change
    rename_column :users, :email_address, :email
  end
end
