require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe ".search_by_title(search_term)" do

     it "should return an empty array if the user submits no parameters" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      expect(Video.search_by_title("")).to eq([])
    end

    it "should return an empty array if it finds no videos" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      expect(Video.search_by_title("test")).to eq([])
    end

    it "should return an array of one video if it is an exact match" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      expect(Video.search_by_title("South Park")).to eq([south_park])
    end

    it "should return an array of one video for a partial match" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      family_guy_2 = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      expect(Video.search_by_title("Family Guy")).to eq([family_guy, family_guy_2])
    end
    it "should return an array of all matches oredered by created_at" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "A funny video", created_at: 2.day.ago)
      family_matters = Video.create(title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 3.day.ago)
      expect(Video.search_by_title("Family")).to eq([family_guy, family_matters])
    end 
  end
end


