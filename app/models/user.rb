class User < ActiveRecord::Base
  include Tokenable

  has_many :followships
  has_many :followers, :through => :followships
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'user_id'
  belongs_to :invitation
  has_secure_password validations: false
  has_many :queue_items, -> { order 'position ASC' }
  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true
  has_many :reviews, -> { order 'created_at DESC' }

  def invite_token
    invitation.invite_token
  end

  def invite_token=(token)
    self.invitation = Invitation.find_by invite_token: token
  end

  def normalise_queue
    queue_count = 0
    queue_items.each do |queue_item|
      queue_count = queue_count + 1
      queue_item.update_column(:position, queue_count)
    end
  end

  def number_of_queue_items
    total = queue_items.count
    total
  end

  def number_of_reviews
    total = reviews.count
    total
  end

  def following?(follower)
    if followers.include?(follower)
      false
    else
      true
    end
  end
end
