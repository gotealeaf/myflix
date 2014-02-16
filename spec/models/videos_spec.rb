require 'spec_helper'

describe Video do
  it { should have_many(:categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there's no match" do
      godfather_one = Video.create(title: "The Godfather One", description: "The story of a mafia familly.")
      godfather_two = Video.create(title: "The Godfather Two", description: "The story of a mafia familly.")

      expect(Video.search_by_title("paquito")).to eq([])
    end

    it "returns an array with one video that has an exact match" do
      godfather_one = Video.create(title: "The Godfather One", description: "The story of a mafia familly.")
      godfather_two = Video.create(title: "The Godfather Two", description: "The story of a mafia familly.")

      expect(Video.search_by_title("The Godfather One")).to eq([godfather_one])
    end

    it "returns an array of one video with a partial match" do
      godfather_one = Video.create(title: "The Godfather One", description: "The story of a mafia familly.")
      godfather_two = Video.create(title: "The Godfather Two", description: "The story of a mafia familly.")

      expect(Video.search_by_title("One")).to eq([godfather_one])
    end

    it "returns an array of all matches that partially match ordered by create_at" do
      godfather_one = Video.create(title: "The Godfather One", description: "The story of a mafia familly.", created_at: 1.day.ago)
      godfather_two = Video.create(title: "The Godfather Two", description: "The story of a mafia familly.")

      expect(Video.search_by_title("The Godfather")).to eq([godfather_two, godfather_one])
    end

    it "returns an empty array if the title searched is an empty array" do
      godfather_one = Video.create(title: "The Godfather One", description: "The story of a mafia familly.", created_at: 1.day.ago)
      godfather_two = Video.create(title: "The Godfather Two", description: "The story of a mafia familly.")   
      
      expect(Video.search_by_title("")).to eq([])   
    end

  end
end

