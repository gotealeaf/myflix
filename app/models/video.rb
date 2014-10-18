class Video < ActiveRecord::Base
	belongs_to :category
	has_many :reviews
	has_many :queue_items
	validates :title, presence: :true
	validates :description, presence: :true

	def self.search_by_title(term)
		return [] if term == ""
		Video.where("title like ?", "%#{term}%").order("created_at DESC")
	end
end