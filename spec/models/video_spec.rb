require 'spec_helper'

describe Video do
  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC")}


  describe "search_by_title" do
    it "returns and empty array if there is no match" do
      south_park = Video.create(
        title:"South Park", 
        description: "Cartman")
      robocop = Video.create(
        title:"Robocop", 
        description:"A action movie from the 80's about cheesy looking robot cop")
      expect(Video.search_by_title("Suckas")).to eq([])
  end

    it "returns an array of one video for an exact match" do
      south_park = Video.create(
        title:"South Park", 
        description: "Cartman")
      robocop = Video.create(
        title:"Robocop", 
        description:"A action movie from the 80's about cheesy looking robot cop")
      expect(Video.search_by_title("South Park")).to eq([south_park])
    end

      it "returns an array of one video for a partial match" do
      south_park = Video.create(
        title:"South Park", 
        description: "Cartman")
      robocop = Video.create(
        title:"Robocop", 
        description:"A action movie from the 80's about cheesy looking robot cop")
      expect(Video.search_by_title("sou")).to eq([south_park])
    end

      it "returns an array of all matches ordered by created_at" do
      south_park = Video.create(
        title:"South Park", 
        description: "Cartman")
      robocop = Video.create(
        title:"Robocop", 
        description:"A action movie from the 80's about cheesy looking robot cop")
      expect(Video.search_by_title("sou")).to eq([south_park])
    end
  end
end



