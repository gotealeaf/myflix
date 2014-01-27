class AddVideoReferenceToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :video
  end
end
