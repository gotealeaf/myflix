require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      result = Video.search_by_title("Visit")
      expect(result).to eq([])
    end

    it "returns an array of one video for an exact match" do
      existing_record = Video.create(title: "The Visit", description: "I was scared")
      result = Video.search_by_title("The Visit")
      expect(result).to eq([existing_record])
    end

    it "returns an array of one video for a partial match" do
      first_video = Video.create(title: "The Visit", description: "I was scared")
      second_video = Video.create(title: "Blackhawk down", description: "waste of money")
      result = Video.search_by_title("sit")
      expect(result).to eq([first_video])
    end

    it "returns an array of all matches ordered by created_at" do
      first_video = Video.create(title: "The Visit", description: "I was scared", created_at: 1.day.ago)
      second_video = Video.create(title: "She Visited Me", description: "waste of money")
      result = Video.search_by_title("sit")
      expect(result).to eq([second_video, first_video])
    end

    it "searched and found 2 without a particular order" do
      Video.create(title: "The Visit", description: "I was scared")
      Video.create(title: "She Visited Me", description: "waste of money")
      existing_records = Video.all
      result = Video.search_by_title("Visit")
      expect(result).to include(existing_records.first, existing_records.last)
    end

    it "returns an empty array for a search with an empty string" do
      first_video = Video.create(title: "The Visit", description: "I was scared", created_at: 1.day.ago)
      second_video = Video.create(title: "She Visited Me", description: "waste of money")
      result = Video.search_by_title("")
      expect(result).to eq([])
    end

  end



end