require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future", description: "Time travel")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future", description: "Time travel")
      expect(Video.search_by_title("futurama")).to eq([futurama])
    end

    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future", description: "Time travel")
      expect(Video.search_by_title("urama")).to eq([futurama])
    end

    it "returns an array of all matching videos order by created_at" do
      futurama = Video.create(title: "futurama", description: "space travel", created_at: 1.day.ago)
      back_to_future = Video.create(title: "back to future", description: "Time travel")
      expect(Video.search_by_title("futur")).to eq([back_to_future, futurama])
    end

    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future", description: "Time travel")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end