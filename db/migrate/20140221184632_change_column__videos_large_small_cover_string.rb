class ChangeColumnVideosLargeSmallCoverString < ActiveRecord::Migration
  def change
  	change_column :videos, :large_cover, :string
  	change_column :videos, :small_cover, :string
  end
end
