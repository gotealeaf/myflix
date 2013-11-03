class Video < ActiveRecord::Base
  has_many :comments
end