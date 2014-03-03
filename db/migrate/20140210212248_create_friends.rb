class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :full_name
      t.string :email
      t.text :message
      t.integer :user_id
      t.timestamps
    end
  end
end
