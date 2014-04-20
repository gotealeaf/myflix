class ChangeVideoCoverColumnNames < ActiveRecord::Migration
  def change
    rename_column :videos, :sm_cover_locn, :small_cover
    rename_column :videos, :lg_cover_locn, :large_cover
  end
end
