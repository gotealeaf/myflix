class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string  :title
      t.text    :description
      t.text    :sm_cover_locn
      t.text    :lg_cover_locn

      t.timestamps
    end
  end
end
