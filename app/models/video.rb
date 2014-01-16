class Video < ActiveRecord::Base
	validates_presence_of :title
	validates_presence_of :description
	belongs_to :category
end
