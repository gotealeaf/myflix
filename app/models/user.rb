class User < ActiveRecord::Base
  include Tokenable
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true
  has_many :reviews, -> { order("created_at DESC")}
  has_many :queue_items, -> { order(:position)}

  has_many :leading_relationships, :class_name => "Relationship", :foreign_key => "leader_id"
  has_many :followers, :through => :leading_relationships
  has_many :following_relationships, :class_name => "Relationship", :foreign_key => "follower_id"
  has_many :leaders, :through => :following_relationships

  has_many :invitations, :foreign_key => "inviter_id"



  has_secure_password

  def can_follow? leader
    !self.follows?(leader)  && (self != leader) 
  end

  def follows? leader
    leaders.include?(leader)
  end

  def follow leader
    Relationship.create(leader: leader, follower: self) if can_follow?(leader)
  end

  def normalize_positions
    queue_items.each_with_index do |q, i|
      # index starts at 0, position at 1
      q.update_attributes(position: i + 1)
    end
  end

end
