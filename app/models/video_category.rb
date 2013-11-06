class Videocategory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :video
  belongs_to :categories
end