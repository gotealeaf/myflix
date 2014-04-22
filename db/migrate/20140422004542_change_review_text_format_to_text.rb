class ChangeReviewTextFormatToText < ActiveRecord::Migration
  def up
   change_column :reviews, :review_text, :text
  end

  def down
   change_column :reviews, :review_text, :string
  end
end
