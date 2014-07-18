class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(:position) } 
  
  validates_presence_of :fullname, :email, :password
  validates_uniqueness_of :email

  has_secure_password validations: false

  def set_queue_position
    queue_items.count + 1
  end

  def normalize_position
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end 
  end

  def video_in_queue?(video)
    queue_items.ids.include?(video.id)
  end
end