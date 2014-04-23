class CreateTokenColumnForUsers < ActiveRecord::Migration
  def change
    create_table :token_column_for_users do |t|
      add_column :users, :token, :string
    end
  end
end
