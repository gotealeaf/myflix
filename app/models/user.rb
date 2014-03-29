class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order('position') } 
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  def repositions_queue_items
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index+1)
    end
  end 

  def queued_item?(video=nil)
    collection = queue_items.map(&:video)
    collection.include?(Video.find(video.id))
  end
end