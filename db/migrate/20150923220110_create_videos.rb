class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :description, :small_cover_url, :large_cover_url
    end
  end
end
