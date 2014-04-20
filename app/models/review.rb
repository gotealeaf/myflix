class Review < ActiveRecord::Base
  belongs_to :video #video_id convention assumed
  belongs_to :user  #user_id convention assumed



  validates_uniqueness_of :user_id,     scope: [ :video_id ]
  validates :user_id,   presence:       true
  validates :video_id,  presence:       true
  validates :rating,    presence:       true,
                        numericality:   { greater_than_or_equal_to:   1,
                                        less_than_or_equal_to:        5 }
  validates :content,   length:         { maximum: 500 }
end
