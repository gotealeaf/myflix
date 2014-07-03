class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_presence_of :user, :video
  validates :position, numericality: { only_integer: true }
  
  before_validation :get_next_position

  def rating
    review = Review.where(user:user, video:video).first
    return review.nil? ? nil : review.rating
  end

  def category_name
    return category.name
  end
  
  #### CLASS METHODS #######################################
  
  def self.assign_positions_for_user(user,position_array)
    objects = []
    position_array.each do |i|
      positions = i.symbolize_keys
      qi = QueueItem.find(positions[:id])
      qi.position = positions[:position]
      objects.push(qi)
    end
    return objects
  end
  
  def self.save_positions_for_user(user,object_array)
    successful = true
    begin
      ActiveRecord::Base.transaction do
        object_array.each do |item|
          item.save! if item.user == user
        end
      end
      self.normalize_item_positions_for_user(user)
    rescue ActiveRecord::RecordInvalid
      successful = false
    end
    return successful
  end
  
  def self.normalize_item_positions_for_user(user)
    user.queue_items.each_with_index do |item,index|
      item.update_attribute(:position, index + 1)
    end
  end
  
  #### PRIVATE METHODS #######################################
  
  private
  
  def get_next_position
    if self.position.nil? && !self.user.nil?
      self.position = self.user.queue_items.empty? ? 1 : (self.user.queue_items.count + 1)
    end
  end

end
