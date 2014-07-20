class Video < ActiveRecord::Base
  include PgSearch

  belongs_to :category

  validates_presence_of :title, :description, :large_cover_image_url, :small_cover_image_url, :category_id

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

end
