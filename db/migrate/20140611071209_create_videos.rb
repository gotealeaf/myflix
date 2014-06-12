class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :year
      t.string :duration
      t.text :description
      t.string :slug
      t.timestamps
    end
  end
end
