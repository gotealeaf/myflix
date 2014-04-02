class Video < ActiveRecord::Base
  belongs_to :category, order: :title
end
