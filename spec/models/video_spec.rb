require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if string does not match any titles" do
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.")
      back_to_future = Video.create(title: "Back to Future", description: "time travel")
      search = "unmatched_title"
      expect(Video.search_by_title(search)).to eq([])
    end

    it "returns a one-video array if the string exactly matches one title" do
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.")
      back_to_future = Video.create(title: "Back to Future", description: "time travel")
      search = "futurama"
      expect(Video.search_by_title(search)).to eq([futurama])
    end

    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.")
      family_comedy = Video.create(title: "Family Comedy", description: "So generic! etc.")
      search = "futur"
      expect(Video.search_by_title(search)).to eq([futurama])
    end

    it "returns an array of all matches, ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", created_at: 1.day.ago)
      family_comedy = Video.create(title: "Family Comedy", description: "So generic! etc.")
      search = "family"
      expect(Video.search_by_title(search)).to eq([family_comedy, family_guy])
    end

    it "returns an empty array when search term is empty string" do
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.")
      family_comedy = Video.create(title: "Family Comedy", description: "So generic! etc.")
      search = ""
      expect(Video.search_by_title(search)).to eq([])
    end
  end
end