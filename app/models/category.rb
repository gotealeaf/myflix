class Category < ActiveRecord::Base
  has_many :videos, -> { order(title: :asc ) }

  validates :name, presence: true, uniqueness: true
end  