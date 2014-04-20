class ChangeVideoColumnTypeForCovers < ActiveRecord::Migration
  def change
    change_column :videos, :sm_cover_locn, :string
    change_column :videos, :lg_cover_locn, :string
  end
end
