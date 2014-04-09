class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :big_cover_url
      t.string :small_cover_url
      t.integer :category_id

      t.timestamps
    end
  end
end
