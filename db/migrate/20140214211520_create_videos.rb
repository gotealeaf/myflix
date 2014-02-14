class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :short_image_url
      t.string :large_image_url

      t.timestamps
    end
  end
end
