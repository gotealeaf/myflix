class RemoveCoverImage < ActiveRecord::Migration
  def change
   remove_column :videos, :cover_image_url, :string
  end
end
