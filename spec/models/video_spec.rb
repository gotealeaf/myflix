require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items) }

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

  describe "rating" do
    it "returns the video's average rating from all its reviews" do
      the_godfather = Fabricate :video
      review1 = Fabricate :review, rating: 3, video: the_godfather
      review2 = Fabricate :review, rating: 4, video: the_godfather

      expect(the_godfather.rating).to eq(3.5)
    end

    it "returns nil when the video has no review" do
      the_godfather = Fabricate :video
      expect(the_godfather.rating).to eq(nil)
    end

    it "returns only one decimal" do
      the_godfather = Fabricate :video
      review1 = Fabricate :review, rating: 3, video: the_godfather
      review2 = Fabricate :review, rating: 4, video: the_godfather
      review3 = Fabricate :review, rating: 1, video: the_godfather

      expect(the_godfather.rating).to eq(2.7)
    end
  end
end

