class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:list_order) }
  
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id # because the table is Relationships and it only contains either leader_id or follower_id, so we need to specify it clearly
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
  has_secure_password validations: false
  
  def normalize_queue_item_list_order
     queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_order: index+1 ) #must be + 1 because index starts with zero
    end
  end
  
  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
  
end