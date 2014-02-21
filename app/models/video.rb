class Video < ActiveRecord::Base
	belongs_to :category	

	def self.comedy
		where(category_id: 1)
	end

	def self.drama
		where(category_id: 2)
	end

	def self.reality
		where(category_id: 3)
	end

end