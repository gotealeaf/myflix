class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order('ranking') }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password :validations => false

  def renumber_queue
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(ranking: index+1)
    end
  end

  def queue_video(video)
    video.queue_items.create(user: self, ranking: next_queue_item_rank) unless queued_video?(video) 
  end

  def next_queue_item_rank
    queue_items.count + 1
  end

  def queued_video?(video)
    video.queue_items.find_by_user_id(id)
  end
end