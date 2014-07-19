class Category < ActiveRecord::Base
  has_many :videos, -> { order('created_at DESC') }

  validates :name, presence: true, uniqueness: true
end
