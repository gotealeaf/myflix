class Video < ActiveRecord::Base
  include PgSearch
  include Tokenify

  belongs_to :category
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items
  validates_presence_of :title, :description,
                        :large_cover_image_url,
                        :small_cover_image_url,
                        :category
  validates_uniqueness_of :title
  pg_search_scope :search,
                  :against => [:title, :description],
                  :using => {
                    :tsearch => {
                      :prefix => true, :dictionary => "english", :any_word => true
                    },
                    :trigram => {
                      :threshold => 0.5,
                      :only => [:title]
                    },
                    :dmetaphone => {
                      :any_word => true
                    }
                  }

  def to_param
    token
  end

  def total_reviews
    reviews.count
  end

  def display_overall_rating
    return "N/A" if reviews.empty?
    cal_average_rating.to_s + "/5.0"
  end

  private
    def cal_average_rating
      reviews.average(:rating).round(1)
    end

end
