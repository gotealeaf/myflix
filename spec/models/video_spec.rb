require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should have_many(:reviews).order("created_at DESC")}

  describe "search_by_title" do
    it "returns an empty array if there are no matches" do
      futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for an exact match" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("futurama")).to eq([futurama])
    end
    it "returns an array of one video for a partial match" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("urama")).to eq([futurama])
    end
    it "returns an array of all matches ordered by created_at" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("futur")).to eq([back_to_future, futurama])
    end
    it "returns an array for a search with an empty string" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end