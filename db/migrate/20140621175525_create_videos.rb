class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :small_cover_url, :large_cover_url, :category
      t.text :description
      t.timestamps
    end
  end
end
