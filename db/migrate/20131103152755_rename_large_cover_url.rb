class RenameLargeCoverUrl < ActiveRecord::Migration
  def change
  	rename_column :videos, :lare_cover_url, :large_cover_url
  end
end
