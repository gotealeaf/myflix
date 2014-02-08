class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :content, :rating

  def has_content?
    return false if content.blank?
    return true
  end

  def has_rating?
    return true if rating && [1,2,3,4,5].include?(rating)
  end
end
