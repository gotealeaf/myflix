class Video < ActiveRecord::Base
  #has_many :video_categories
  #has_many :categories,  -> { distinct }, through: :video_categories
  include Sluggable
  belongs_to :category, foreign_key: 'category_id'
  
  has_many :reviews, -> {order('created_at DESC')}
  validates_presence_of :title, :description

  sluggable_column :title

  
  
  def self.search_by_title(name)
    return [] if name.blank?
    Video.where(["title LIKE ?", "%#{name}%"]).order('created_at DESC')

  end

  #def generate_token #not needed in the apps context as new videos are not being created.
  #  self.token = SecureRandom.urlsafe_base64
  #end

end
