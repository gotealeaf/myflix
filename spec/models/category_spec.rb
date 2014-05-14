require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    before { category = Fabricate(:category) }

    it "should return an empty array if the category contains no videos" do
      expect(Category.first.recent_videos).to eq([])
    end
    
    it "should return the videos within a category if the category contains videos" do
      video1 = Fabricate(:video, category_id: Category.first.id, created_at: 1.day.ago)
      video2 = Fabricate(:video, category_id: Category.first.id, created_at: 2.days.ago)
      expect(Category.first.recent_videos).to eq([video1, video2])
    end

    it "should return the videos within a category sorted by date created with most recent video first" do
      video1 = Fabricate(:video, category_id: Category.first.id, created_at: 1.day.ago)
      video2 = Fabricate(:video, category_id: Category.first.id, created_at: 2.days.ago)
      video3 = Fabricate(:video, category_id: Category.first.id, created_at: 3.days.ago)
      expect(Category.first.recent_videos).to eq([video1, video2, video3])
    end

    it "should return only the most recently created 6 videos in a category if the category contains more than 6 videos" do
      video1 = Fabricate(:video, category_id: Category.first.id, created_at: 1.day.ago)
      video2 = Fabricate(:video, category_id: Category.first.id, created_at: 2.days.ago)
      video3 = Fabricate(:video, category_id: Category.first.id, created_at: 3.days.ago)
      video4 = Fabricate(:video, category_id: Category.first.id, created_at: 4.days.ago)
      video5 = Fabricate(:video, category_id: Category.first.id, created_at: 5.days.ago)
      video6 = Fabricate(:video, category_id: Category.first.id, created_at: 6.days.ago)
      video7 = Fabricate(:video, category_id: Category.first.id, created_at: 7.days.ago)
      expect(Category.first.recent_videos).to eq([video1, video2, video3, video4, video5, video6])
    end
  end
end

    