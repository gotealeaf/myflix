class Video < ActiveRecord::Base
  include PgSearch

  belongs_to :category
  has_many :reviews

  validates_presence_of :title, :description,
                        :large_cover_image_url,
                        :small_cover_image_url,
                        :category_id

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
  def total_reviews
    reviews.count
  end

  def rating
    return "N/A" if reviews.empty?
    cal_rating
  end

  private
    def cal_rating
      overall = reviews.inject(0) {|sum, review| sum + review.rating.to_f }/total_reviews

      return overall.round(1).to_s + "/5"
    end
end
