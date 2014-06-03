require 'spec_helper'

describe Video do
  it { should have_many(:categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC") } #{ order("created_at DESC") }
  
  describe "#search_by_title" do
    
    it "returns empty array if no match is found" do
      robocop = Video.create(title: "Robocop", description: "Action movie")
      twilight = Video.create(title: "Twilight", description: "Sappy romance shit")
      Video.search_by_title("bones")
      expect(Video.search_by_title("bones")).to eq([])
    end
    
    it "returns an array of one title if exact title is present" do
      robocop = Video.create(title: "Robocop", description: "Action movie")
      Video.search_by_title("Robocop")
      expect(Video.search_by_title("Robocop")).to eq([robocop])
    end
      
    it "returns an array of one title if partial match is found" do
      robocop = Video.create(title: "Robocop", description: "Action movie")
      Video.search_by_title("Robo")
      expect(Video.search_by_title("Robo")).to eq([robocop])
    end
    
    it "returns an array of all matches if similar titles are present ordered by created at" do
      robocop = Video.create(title: "Robocop", description: "Action movie", created_at: 1.day.ago)
      cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story")
      expect(Video.search_by_title("cop")).to eq([cops_and_robbers, robocop])
    end
    
    it "returns an empty array if user submitted empty search query" do
      robocop = Video.create(title: "Robocop", description: "Action movie", created_at: 1.day.ago)
      cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end


