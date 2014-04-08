require 'spec_helper'

describe Category do
  it {should have_many(:videos)}
  describe "recent_videos" do
    before (:each) do
      @category1 = Category.create(name: "category1")
    end
    it "return empty array when no video" do
      expect(@category1.recent_videos).to eq []
    end
    describe "x" do
      before (:each) do
        @video1 = Video.create(title: "video1",description: 'x', created_at: 1.day.ago )
        @video2 = Video.create(title: "video2",description: 'x', created_at: 5.day.ago )
        @video3 = Video.create(title: "video3",description: 'x', created_at: 3.day.ago )
        @video4 = Video.create(title: "video4",description: 'x', created_at: 6.day.ago )
        @video5 = Video.create(title: "video5",description: 'x', created_at: 4.day.ago )
        @category1 = Category.create(name: "category1", videos: [@video1, @video2, @video3, @video4, @video5] )

      end
      it "return six videos in reverse chronological order when having more than six videos" do
        @video6 = Video.create(title: "video6",description: "X",created_at: 2.day.ago , category: @category1)
        @video7 = Video.create(title: "video7",description: "X",created_at: 7.day.ago , category: @category1)
        expect(@category1.recent_videos).to eq [ @video1, @video6, @video3, @video5, @video2, @video4 ]
      end
      it "return some videos when having videos less than six videos" do
        expect(@category1.recent_videos).to eq [ @video1, @video3, @video5, @video2, @video4 ]
      end
    end
  end
end
