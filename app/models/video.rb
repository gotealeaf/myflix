class Video < ActiveRecord::Base
  belongs_to :category, :class_name => 'Category', :foreign_key => 'categories_id'
end
