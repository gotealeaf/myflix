require 'spec_helper'

describe Video do
  
  it { should have_many(:categories).through(:video_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  
  
  describe "#search by title" do
    it "returns one video if one video found" do
      star_wars = Video.create(title: "Star Wars", description: "A great space movie!")
      star_trek = Video.create(title: "Star Trek", description: "Almost a great space movie!")
      expect(Video.search_by_title("trek")).to match_array([star_trek])
    end
    it "returns an array of multiple videos if multiple videos found" do
      star_wars = Video.create(title: "Star Wars", description: "A great space movie!")
      star_trek = Video.create(title: "Star Trek", description: "Almost a great space movie!")
      expect(Video.search_by_title("star")).to match_array([star_trek, star_wars])
    end
    it "returns an empty array if no videos found" do
      star_wars = Video.create(title: "Star Wars", description: "A great space movie!")
      star_trek = Video.create(title: "Star Trek", description: "Almost a great space movie!")
      expect(Video.search_by_title("house")).to match_array([])
    end
    it "returns an empty array if no search term entered" do
      star_wars = Video.create(title: "Star Wars", description: "A great space movie!")
      star_trek = Video.create(title: "Star Trek", description: "Almost a great space movie!")
      expect(Video.search_by_title("")).to match_array([])
    end
  end
  
end