require 'spec_helper'


describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews) }
  describe ".search_by_title" do
    it "returns empty array if no match in search result" do
      monk = Video.create(title: "Monk", description: "This is monk movie")
      expect(Video.search_by_title("family")).to eq([])
    end

    it "returns one array if there is 1 match" do
      monk = Video.create(title: "Monk", description: "This is monk movie")
      futurama = Video.create(title: "Futurama", description: "This is futurama movie")
      expect(Video.search_by_title("Monk")).to eq([monk])
    end

    it "returns many record if search result is many" do
      monk = Video.create(title: "Monk", description: "This is monk movie")
      monk2 = Video.create(title: "Monk 2", description: "This is monk 2 movie")
      expect(Video.search_by_title("Monk")).to eq([monk2, monk])
    end
  end
end