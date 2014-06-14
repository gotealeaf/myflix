class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: :true
  validates :description, presence: :true

  # if you're only validating 'presence' you can use this syntax instead:
  # validates_presence_of :title, :description
end