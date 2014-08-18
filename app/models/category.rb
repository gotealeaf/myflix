class Category < ActiveRecord::Base 
has_many :videos , -> {order("created_at DESC")}
end 
