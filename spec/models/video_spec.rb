require 'spec_helper'

describe Video do 
  #it "saves itself" do                      #THERE ARE THREE STEPS TO WRITE A TEST
  #  video = Video.new(title: "xyz", description: "more xyz", small_cover_url: "test short",
  #    large_cover_url: "test large cover")  #setup or stage the test data
  #  video.save                              #perform action
  #  expect(Video.first).to eq(video)       #verify the result

  #end
  
  #testing validations
  it {should belong_to(:category)}  #using shoulda-matchers: Checking that Video belongs_to Category
  it {should validate_presence_of(:title)} #shoulda-matchers
  it {should validate_presence_of(:description)} #shoulda-matchers
  it {should have_many(:reviews).order("created_at DESC")}
  describe "search_by_title" do
    it "returns empty array if no video titles contain the search string" do
      chak = Video.create(title: "chak_de", description: "chak de description")
      monk = Video.create(title: "monk", description: "monk description")
      
      expect(Video.search_by_title("zoo")).to eq([])


    end

    it "returns arrays of one video if one video title exactly matches the search string" do
      chak = Video.create(title: "chak_de", description: "chak de description")
      monk = Video.create(title: "monk", description: "monk description")
    
      expect(Video.search_by_title("monk")).to eq([monk])

    end
    
    it "returns array of one video if one video title partially contains the search string" do
      chak = Video.create(title: "chak_de", description: "chak de description")
      monk = Video.create(title: "monk", description: "monk description")
    
      expect(Video.search_by_title("mon")).to eq([monk])

    end
    

    it "returns all the videos whose titles contain the search string ordered by created_at" do
      chak = Video.create(title: "chak_de", description: "chak de description", created_at: 1.day.ago)
      monk = Video.create(title: "monk", description: "monk description")
    
      expect(Video.search_by_title("k")).to eq([monk, chak])

    end

    it "returns an empty array for a search with empty string" do
      chak = Video.create(title: "chak_de", description: "chak de description")
      monk = Video.create(title: "monk", description: "monk description")
    
      expect(Video.search_by_title("")).to eq([])

    end
    


  end

   

  

end