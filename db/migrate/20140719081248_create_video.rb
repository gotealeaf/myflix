class CreateVideo < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :large_cover_image_url
      t.string :small_cover_image_url
    end
  end
end
