require 'spec_helper'

describe Category do

  it {should have_many(:videos)}

  describe "recent_videos" do

    let(:category) { Fabricate(:category) }

    it "return empty array when no video" do
      expect(category.recent_videos).to eq []
    end
    describe "x" do
      before (:each) do
        @video1 = Fabricate(:video, created_at: 1.day.ago, category: category)
        @video2 = Fabricate(:video, created_at: 5.day.ago, category: category)
        @video3 = Fabricate(:video, created_at: 3.day.ago, category: category)
        @video4 = Fabricate(:video, created_at: 6.day.ago, category: category)
        @video5 = Fabricate(:video, created_at: 4.day.ago, category: category)
      end
      it "return some videos when having videos less than six videos" do
        expect(category.recent_videos).to eq [ @video1, @video3, @video5, @video2, @video4 ]
      end
      it "return six videos in reverse chronological order when having more than six videos" do
        @video6 = Fabricate(:video, created_at: 2.day.ago, category: category)
        @video7 = Fabricate(:video, created_at: 7.day.ago, category: category)
        expect(category.recent_videos).to eq [ @video1, @video6, @video3, @video5, @video2, @video4 ]
      end
    end
  end
end
