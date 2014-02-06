require 'spec_helper'

describe Category do 

  it {should have_many(:videos)}

  describe '#recent_videos' do
    let!(:category1) {Fabricate(:category, name: "Category1")}

    it "returns and empty array if there are none in a category" do
      romance = Category.create(name: "Romance")
      expect(romance.recent_videos).to eq([])
    end
    it "returns all videos if there are 6 or fewer" do
      4.times  {Video.create(title: "movie", description: "plot", category: category1)}
      expect(category1.recent_videos.count).to eq(4)
    end

    it "returns 6 videos if there are more than 6" do
      7.times  {Video.create(title: "movie", description: "plot", category: category1)}
      expect(category1.recent_videos.count).to eq(6)
    end

    it "returns most recent 6 videos if there are more than 6" do
      6.times  {Video.create(title: "movie", description: "plot", category: category1)}
      elder = Video.create(title: "movie", description: "plot",created_at: 1.day.ago,  category: category1)
      expect(category1.recent_videos).not_to include elder
    end
  end

  describe "remaining videos" do
    let!(:category1) {Fabricate(:category, name: "Category1")}
    it "should return the total less six videos" do
      6.times {Fabricate(:video, title: "Initial",  category: category1)}
      12.times {Fabricate(:video, title: "Remaining",created_at: 1.day.ago,  category: category1)}
      expect(category1.remaining_videos.count).to eq(12)
      expect(category1.remaining_videos.first.title).to eq("Remaining")
    end
    it "should return no videos if there are 6 or less" do
      6.times {Fabricate(:video, title: "Initial",  category: category1)}
       expect(category1.remaining_videos.count).to eq(0)
    end
  end

end
