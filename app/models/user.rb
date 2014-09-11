class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true
  has_many :reviews
  has_many :queue_items, -> { order(:position)}

  has_secure_password

  def normalize_positions
    queue_items.each_with_index do |q, i|
      # index starts at 0, position at 1
      q.update_attributes(position: i + 1)
    end
  end
end
