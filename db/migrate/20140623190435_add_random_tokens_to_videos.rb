class AddRandomTokensToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :token, :string
    Video.all.each do |video|
      video.token = SecureRandom.urlsafe_base64
      video.save
    end
  end
end
