class User < ActiveRecord::Base

  has_many :reviews
  has_many :queue_items, -> { order("ranking") }

  has_secure_password validation: false
  validates_presence_of :email, :full_name
  validates_presence_of :password, :password_confirmation, on: :create
  validates_length_of :password, :password_confirmation,
                      minimum: 5, on: :create, too_short: 'please enter at least 6 characters'
  validates :email, uniqueness: true #format


  def reset_order_ranking
    queue_items.each_with_index do |item, index|
      item.update(ranking: index + 1 )
    end
  end

  def new_item_position
    queue_items.count + 1
  end


  def has_video?(video_id)
    queue_items.map(&:video_id).include?(video_id)
  end

  def make_queue_item(video_id)
    queue_items.create(video_id: video_id, ranking: new_item_position)
  end
end
