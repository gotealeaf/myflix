class User < ActiveRecord::Base
  include Tokenable
  validates_presence_of :email, :full_name
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email
  validates_length_of :full_name, in: 3..25
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order(:list_order) }
  has_many :invitations, foreign_key: :inviter_id
  has_many :payments
  
  
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id # because the table is Relationships and it only contains either leader_id or follower_id, so we need to specify it clearly
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  
  has_secure_password validations: false
  
  #before_create :generate_token
  
  def normalize_queue_item_list_order
     queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_order: index+1 ) #must be + 1 because index starts with zero
    end
  end
  
  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
  
  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end
  
  def follow(another_user)
    following_relationships.create(leader: another_user) if can_follow?(another_user)
  end
  
  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user) #can only follow if you are not the other user or not following the other user
  end
  
  def new_invite?(recipient)
    !(self.invitations.map(&:recipient_email).include?(recipient))
  end
  
  def deactivate!
    update_column(:active, false)
  end
  
  def next_billing_date
    self.payments.last.created_at + 1.month
  end
  
  def previous_billing_date
    self.payments.last.created_at
  end
  
  #def generate_token
    #self.token = SecureRandom.urlsafe_base64
  #end
  
end