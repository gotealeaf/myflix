class Video < ActiveRecord::Base
  validates :name, presence: true

  def to_param
    self.slug
  end
end
