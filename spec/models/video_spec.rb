require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }
  it { should have_many(:reviews).order(created_at: :desc) }

  it "returns an array of reviews in reverse chronological order" do
    video = Fabricate(:video)
    review_1 = Fabricate(:review, video: video, created_at: 2.day.ago)
    review_2 = Fabricate(:review, video: video)
    expect(video.reviews).to eq([review_2, review_1])
  end

  describe "#search_by_title" do
    it "returns an empty array if there is no match" do
      Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("not")

      expect(search_rslt).to eq([])
    end
    
    it "returns an array of a single matched video" do
      monk = Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("Monk")

      expect(search_rslt).to eq([monk])      
    end

    it "returns an array of a single matched video in a different case" do
      monk = Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("mONK")

      expect(search_rslt).to eq([monk])
    end

    it "returns an array of a single partially matched video" do
      familyguy = Video.create(title: "Family Guy", description: "A funny family.")
      search_rslt = Video.search_by_title("Family")

      expect(search_rslt).to eq([familyguy])
    end

    it "returns an array of multiple matached videos ordered by created_at" do
      familymatters = Video.create(title: "Family Matters", description: "A Chicago family.")
      familyguy = Video.create(title: "Family Guy", description: "A funny family.", created_at: "2013-03-18 04:53:45")
      search_rslt = Video.search_by_title("Family")

      expect(search_rslt).to eq([familyguy, familymatters])
    end

    it "returns an empty array if search term is blank" do
      familymatters = Video.create(title: "Family Matters", description: "A Chicago family.")
      familyguy = Video.create(title: "Family Guy", description: "A funny family.", created_at: "2013-03-18 04:53:45")
      search_rslt = Video.search_by_title("")

      expect(search_rslt).to eq([])
    end
  end
end