class DropUserVideos < ActiveRecord::Migration
  def up
    drop_table :user_videos
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
