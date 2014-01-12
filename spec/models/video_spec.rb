require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:description)}
  
  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      simpsons = Video.create(name: "Simpsons", description: "how long can it go")
      drwho = Video.create(name: "DrWho", description: "it's about time travel! also a long running show")
      expect(Video.search_by_title("Hello")).to eq([])
    end
    it "returns an array of one video for an exact match" do
      fg = Video.create(name: "Family Guy", description: "how long can it go")
      drwho = Video.create(name: "DrWho", description: "it's about time travel! also a long running show")
      expect(Video.search_by_title("Family Guy")).to eq([fg])
    end
    it "returns an array of one video for a partial match" do
      sherlock = Video.create(name: "Sherlock", description: "how long can it go")
      drwho = Video.create(name: "Dr. Who", description: "it's about time travel! also a long running show")
      expect(Video.search_by_title("lock")).to eq([sherlock])
    end
    it "returns an array of all matches ordered by creation date/time" do
      community = Video.create(name: "community", description: "how long can it go", created_at: 1.day.ago)
      comm = Video.create(name: "Community season 1", description: "it's about time travel! also a long running show")
      expect(Video.search_by_title("comm")).to eq([comm, community])
    end 
    it "returns an empty array for an empty search query" do
      expect(Video.search_by_title("")).to eq([])
      
    end
    
  end
end