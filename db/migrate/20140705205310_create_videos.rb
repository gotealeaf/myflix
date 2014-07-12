class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :small_url
      t.string :large_url
      t.timestamps
    end
  end
end
