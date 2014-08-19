class ChangeColumnUrlVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :url_long, :url_large
  end
end
