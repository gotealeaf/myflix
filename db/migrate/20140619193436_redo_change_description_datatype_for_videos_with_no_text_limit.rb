class RedoChangeDescriptionDatatypeForVideosWithNoTextLimit < ActiveRecord::Migration
  def change
    change_column :videos, :description, :text, limit: nil
  end
end
