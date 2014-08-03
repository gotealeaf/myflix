class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates :rating, presence: true
  validates :content, presence: true

  def self.order_by_created_at
    self.order("created_at DESC")
  end

end