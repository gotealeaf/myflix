class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.string :title
    	t.text :description
    	t.string :small_cover
    	t.string :big_cover
    	t.timestamps
    end
  end
end
