require 'rails_helper.rb'

# shoulda gem syntax
describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do
    it "return an empty array if no match" do
      ghostbusters = Video.create(title: "Ghostbusters", description: "30th anniversary")
      psycho = Video.create(title: "Psycho", description: "Classic Hitchcock")
      expect(Video.search_by_title("Test")).to eq([])
    end
    it "returns an array of one video for exact match" do
      ghostbusters = Video.create(title: "Ghostbusters", description: "30th anniversary")
      psycho = Video.create(title: "Psycho", description: "Classic Hitchcock")
      expect(Video.search_by_title("Ghostbusters")).to eq([ghostbusters])
    end
    it "return an array of one video for a partial match" do
      ghostbusters = Video.create(title: "Ghostbusters", description: "30th anniversary")
      psycho = Video.create(title: "Psycho", description: "Classic Hitchcock")
      expect(Video.search_by_title("Ghost")).to eq([ghostbusters])
    end
    it "returns an array of all matches ordered by created_at" do
      ghostbusters = Video.create(title: "Ghostbusters", description: "30th anniversary", created_at: 1.day.ago)
      ghostbusters2 = Video.create(title: "Ghostbusters 2", description: "30th anniversary")
      psycho = Video.create(title: "Psycho", description: "Classic Hitchcock")
      expect(Video.search_by_title("Ghost")).to eq([ghostbusters2, ghostbusters])
    end
    it "returns an empty array for an empty string search" do
      ghostbusters = Video.create(title: "Ghostbusters", description: "30th anniversary")
      psycho = Video.create(title: "Psycho", description: "Classic Hitchcock")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
