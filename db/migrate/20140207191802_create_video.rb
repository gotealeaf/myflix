class CreateVideo < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :small_cover, :large_cover
      t.text :description
      t.timestamp :created_at
    end
  end
end
