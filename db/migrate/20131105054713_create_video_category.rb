class CreateVideoCategory < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.belongs_to :video
      t.belongs_to :category
    end
  end
end
