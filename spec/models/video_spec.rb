require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }

  describe "#search_by_title" do
    it "returns an empty array if there is no match" do
      Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("not")

      expect(search_rslt).to eq([])
    end
    
    it "returns an array of a single matched object" do
      monk = Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("Monk")

      expect(search_rslt).to eq([monk])      
    end

    it "returns an array of a single matched object in a different case" do
      monk = Video.create(title: "Monk", description: "A funny man.")
      search_rslt = Video.search_by_title("mONK")

      expect(search_rslt).to eq([monk])
    end

    it "returns an array of a partially matched object" do
      familyguy = Video.create(title: "Family Guy", description: "A funny family.")
      search_rslt = Video.search_by_title("Family")

      expect(search_rslt).to eq([familyguy])
    end

    it "returns an array of multiple matched obejcts" do
      familymatters = Video.create(title: "Family Matters", description: "A Chicago family.")
      familyguy = Video.create(title: "Family Guy", description: "A funny family.")
      search_rslt = Video.search_by_title("Family")

      expect(search_rslt).to eq([familymatters, familyguy])
    end

    it "returns an array of all mataches ordered by created_at" do
      familymatters = Video.create(title: "Family Matters", description: "A Chicago family.")
      familyguy = Video.create(title: "Family Guy", description: "A funny family.", created_at: "2013-03-18 04:53:45")
      search_rslt = Video.search_by_title("Family")

      expect(search_rslt).to eq([familyguy, familymatters])
    end
  end
end