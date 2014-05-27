class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :smallimageurl, :largeimageurl
      t.text :description
    end
  end
end
