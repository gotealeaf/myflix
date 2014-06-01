class RenameColumnLargeCoverUrl < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.rename :large_cove_url, :large_cover_url
    end
  end
end
