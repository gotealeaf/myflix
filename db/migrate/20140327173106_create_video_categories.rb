class CreateVideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.references :video,    index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
