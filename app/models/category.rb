class Category < ActiveRecord::Base 
   has_many :videos , -> {order("created_at DESC")}
   validates_presence_of :name, :description, message: "can't be blank" 
end 
