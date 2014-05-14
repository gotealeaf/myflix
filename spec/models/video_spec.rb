require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { validate_presence_of(:title) }
  it { should validate_presence_of(:description) } 


  describe "search_by_title" do
    it "returns an empty array if there is no video" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("lost")).to eq([])
    end
    
    it "returns an array with one video if there an exact match" do
       f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("family guy")).to eq([f_guy])
    end

    it "returns an array with one video if there a partial match" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("guy")).to eq([f_guy])
    end

    it "returns an array all matches orderd by created_at" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow", created_at: 1.day.ago)
      expect(Video.search_by_title("family")).to eq([f_guy, f_feud])
    end

    it "returns an empty array if the search is an empty string" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end