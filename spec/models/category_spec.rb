require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns an empty array if there are no videos" do
      comedy = Category.create(name: "Comedy")
      expect(comedy.recent_videos).to eq([])
    end

    it "returns an array of all videos if there are fewer then 6" do
      comedy = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "A loud drunk father.", category: comedy)
      futurama = Video.create(title: "Futurama", description: "An pizza delievery boy gets frozen.", category: comedy)

      expect(comedy.recent_videos).to eq([family_guy, futurama])
    end
    
    it "returns an array the 6 most recently modified videos if there are more then 6"
    it "retuns an array of videos in chronological order"
  end
end