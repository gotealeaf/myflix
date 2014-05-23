require "spec_helper"

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns videos in reverse chronological order" do |variable|
      category = Category.create(name: "Dramas", id: 1)
      rudy = Video.create(title: "Rudy", description: "Heartwarming drama", category: category, created_at: 1.day.ago)
      lost = Video.create(title: "Lost", description: "Mystery drama", category: category, created_at: 2.days.ago)
      expect(category.recent_videos).to eq([rudy, lost])
    end

    it "returns all videos if there are less than 6" do
      category = Category.create(name: "Dramas", id: 1)
      rudy = Video.create(title: "Rudy", description: "Heartwarming drama", category: category)
      lost = Video.create(title: "Lost", description: "Mystery drama", category: category)
      bsg = Video.create(title: "Battle Star Galactica", description: "Sci-Fi drama", category: category)
      expect(category.recent_videos.count).to eq(3)
    end

    it "returns only 6 videos if there are more than 6" do
      category = Category.create(name: "Dramas", id: 1)
      7.times { Video.create(title: "Rudy", description: "Heartwarming drama", category: category) }
      expect(category.recent_videos.count).to eq(6)
    end

    it "returns 6 videos ordered by most recent" do
      category = Category.create(name: "Dramas", id: 1)
      rudy = Video.create(title: "Rudy", description: "Heartwarming drama", category: category, created_at: 4.day.ago)
      lost = Video.create(title: "Lost", description: "Mystery drama", category: category, created_at: 5.days.ago)
      bsg = Video.create(title: "Battle Star Galactica", description: "Sci-Fi drama", category: category, created_at: 6.days.ago)
      rudy2 = Video.create(title: "Rudy", description: "Heartwarming drama", category: category, created_at: 1.days.ago)
      lost2 = Video.create(title: "Lost", description: "Mystery drama", category: category, created_at: 2.days.ago)
      bsg2 = Video.create(title: "Battle Star Galactica", description: "Sci-Fi drama", category: category, created_at: 3.days.ago)
      rudy3 = Video.create(title: "Rudy", description: "Heartwarming drama", category: category, created_at: 7.days.ago)
      expect(category.recent_videos).to eq([rudy2, lost2, bsg2, rudy, lost, bsg])
    end

    it "returns an empty array if there are no videos" do
      category = Category.create(name: "Dramas", id: 1)
      expect(category.recent_videos).to eq([])
    end
  end
end
