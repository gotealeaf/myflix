class Video < ActiveRecord::Base
  validates :name, presence: true
end
