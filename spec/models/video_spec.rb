require 'spec_helper'

describe Video do 
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should have_many(:reviews).order("created_at DESC") }

  describe "search_by_title" do 
    it "returns empty array if there is match" do 
      homeland = Video.create(title: "Homeland", description: "Spy Stories")
      dexter = Video.create(title: "Dexter", description: "Detective")
      expect(Video.search_by_title("hello")).to eq([])
    end


    it "returns array of one video for exact match" do
      homeland = Video.create(title: "Homeland", description: "Spy Stories")
      dexter = Video.create(title: "Dexter", description: "Detective")
      expect(Video.search_by_title("Homeland")).to eq([homeland])
    end

    it "returns array of one video for partial match" do 
      homeland = Video.create(title: "Homeland", description: "Spy Stories")
      dexter = Video.create(title: "Dexter", description: "Detective")
      expect(Video.search_by_title("Home")).to eq([homeland])
    end
    
    it "returns array of multiple vidoes of all matches ordered by created_at" do
      homeland = Video.create(title: "Homeland", description: "Spy Stories", created_at: 1.day.ago)
      dexter = Video.create(title: "Dexter", description: "Detective")
      expect(Video.search_by_title("e")).to eq([dexter, homeland])
    end
  
    it "returns an empty array for a serh with an empty string" do
      homeland = Video.create(title: "Homeland", description: "Spy Stories", created_at: 1.day.ago)
      dexter = Video.create(title: "Dexter", description: "Detective")
      expect(Video.search_by_title("")).to eq([])
    end
  end 
  
end

