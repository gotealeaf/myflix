class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}, uniqueness:true
end