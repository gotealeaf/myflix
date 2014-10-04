class Category < ActiveRecord::Base
	has_many :videoes, -> {order("title")}

	def recent_videos		
		self.videoes.order(created_at: :desc).take(6)
	end
end