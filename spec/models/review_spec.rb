require 'spec_helper'

describe Review do
  
  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:description) }

  describe "find recent videos do" do

    it "sorts reviews in reverse cron order" do
      video1 = Video.create(title: "Bullwinkle", description: "Moose movie")
      review1 = Review.create(rating: 4, description: "Almost fabulous", video_id: 1, user_id: 1)
      review2 = Review.create(rating: 1, description: "hated it", video_id: 1, user_id: 1)

      expect(video1.reviews).to eq([review2,review1])

    end 
  end



end
