class Video < ActiveRecord::Base
belongs_to :category

validates :name, presence: true
validates :description, presence: true

#validates_presence_of :title, :description
end
