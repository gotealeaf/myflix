require 'spec_helper'

describe Category do

  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    let(:comedies) { Fabricate(:category, name: "comedies") }

    it "returns videos in reverse chronological order by created at" do
      futurama = Fabricate(:video, category: comedies, created_at: 1.day.ago)
      south_park = Fabricate(:video, category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      futurama = Fabricate(:video, category: comedies)
      south_park = Fabricate(:video, category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns only the six most recent if there is more than 6" do
      7.times { Fabricate(:video, category: comedies) }
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      6.times { Fabricate(:video, category: comedies) }
      tonights_show = Fabricate(:video, category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it "returns an empty array if the category has no videos" do
      expect(comedies.recent_videos).to eq([])
    end
  end
end
