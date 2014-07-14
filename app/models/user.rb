class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true

  has_secure_password
  has_many :reviews
  has_many :queue_items, -> {order('position ASC')}
  
  after_create :new_auth_token

  def new_auth_token
    generate_token(:auth_token)
    save(validate:false)
  end
  
  def normalize_queue_positions
    queue_items.each_with_index do |item,index|
      item.update_attribute(:position, index + 1)
    end
  end
  
  def queued_video?(video)
    queue_items.where(video:video).exists? ? true : false
  end


  private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while self.class.where(column => self[column]).exists?
  end
end
