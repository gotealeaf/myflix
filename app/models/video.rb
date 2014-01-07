class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, :description, presence: true
end
