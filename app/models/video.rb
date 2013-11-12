class Video < ActiveRecord::Base
	belongs_to :category

	#validates :name, presence: true
	#validates :description, presence: true
	validates_presence_of :name, :description

	def self.search_by_name(search_term)
		return [] if search_term.blank?
		where("name LIKE ?", "%#{search_term}%").order("created_at DESC")
	end
end