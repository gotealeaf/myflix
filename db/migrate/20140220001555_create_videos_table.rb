class CreateVideosTable < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.string :title
    	t.string :description
    	t.binary :small_cover
    	t.binary :large_cover
    	t.timestamps
    end
  end
end
