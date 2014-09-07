class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :small_cover_url
      t.string :large_cover_url
    end
  end
end
