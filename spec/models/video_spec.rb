require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      game1 = Video.create(title: "game1", description: "game1")
      game2 = Video.create(title: "game2", description: "game2")
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for exact match" do
      game1 = Video.create(title: "game1", description: "game1")
      game2 = Video.create(title: "game2", description: "game2")
      expect(Video.search_by_title("game1")).to eq([game1])
    end
    it "returns an array of one video for partail match" do
      game1 = Video.create(title: "game1", description: "game1")
      game2 = Video.create(title: "hey", description: "game2")
      expect(Video.search_by_title("ame")).to eq([game1])
    end
    it "returns an array of videos orderd by create_at" do
      game1 = Video.create(title: "game1", description: "game1", created_at: 1.day.ago)
      game2 = Video.create(title: "game2", description: "game2")
      expect(Video.search_by_title("game")).to eq([game2,game1])
    end
    it "returns an empty array if search item is empty" do
      game1 = Video.create(title: "game1", description: "game1")
      game2 = Video.create(title: "game2", description: "game2")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
