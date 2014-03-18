require "spec_helper"

describe Category do
  it { should have_many(:videos).through(:video_categories) }

  describe "#recent_videos" do
    it "returns the videos in the reverse chronological order by created_at" do
      dramas = Category.create(name: "TV Dramas")
      monk = Video.create(title: "Monk", description: "A Detective with OCD", categories: [dramas])
      csi = Video.create(title: "CSI", description: "People use cool computers to solve crimes in impossible amounts of time", categories: [dramas], created_at: 1.day.ago)
      expect(dramas.recent_videos).to eq([monk, csi])
    end

    it "returns all the videos if there are less than 6 videos" do
      dramas = Category.create(name: "TV Dramas")
      monk = Video.create(title: "Monk", description: "A Detective with OCD", categories: [dramas])
      csi = Video.create(title: "CSI", description: "People use cool computers to solve crimes in impossible amounts of time", categories: [dramas], created_at: 1.day.ago)
      expect(dramas.recent_videos.count).to eq(2)
    end

    it "only returns 6 videos if there are more than 6 videos" do
      dramas = Category.create(name: "TV Dramas")
      7.times { Video.create(title: "A TV Drama", description: "This describes the show perfectly", categories: [dramas]) }
      expect(dramas.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      dramas = Category.create(name: "TV Dramas")
      6.times { Video.create(title: "A TV Drama", description: "This describes the show perfectly", categories: [dramas]) }
      old_show = Video.create(title: "Old Show", description: "An old show for this test", categories: [dramas], created_at: 1.day.ago)
      expect(dramas.recent_videos).not_to include(old_show)
    end

    it "returns an empty array if there are no videos in the category" do
      dramas = Category.create(name: "TV Dramas")
      expect(dramas.recent_videos).to eq([])
    end

  end
end  