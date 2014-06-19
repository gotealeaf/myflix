require 'rails_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews) }

  describe "search_by_title" do

    it "returns empty array for a search for a title that does not exist" do
      Video.create(title:'The Matrix Reloaded', description:'There is no spoon.')
      expect(Video.search_by_title('Star Wars')).to eq([])
    end

    it "returns array with one object if an exact match" do
      aliens = Video.create(title:'Aliens', description:'Nuke it from orbit')
      expect(Video.search_by_title('Aliens')).to eq([aliens])
    end

    it "returns one object if there is one record for the sarch term in its title" do
      matrix = Video.create(title:'The Matrix Reloaded', description:'There is no spoon.')
      Video.create(title: 'Star Wars IV', description: 'Long long ago...')
      expect(Video.search_by_title('Matrix')).to eq([matrix])
    end

    it "returns array of objects if multiple records contain the word searched for in their titles" do
      Video.create(title:'The Matrix Reloaded', description:'There is no spoon.')
      star_wars_four = Video.create(title: 'Star Wars IV', description: 'Long long ago...')
      star_wars_five = Video.create(title: 'Star Wars V', description: 'Hot is cold...')
      expect(Video.search_by_title('Star Wars')).to include(star_wars_four,star_wars_five)
    end

    it "returns results in order of created_at" do
      Video.create(title:'The Matrix Reloaded', description:'There is no spoon.')
      star_wars_five = Video.create(title: 'Star Wars V', description: 'Hot is cold...')
      star_wars_four = Video.create(title: 'Star Wars IV', description: 'Long long ago...', created_at: 1.day.ago)
      expect(Video.search_by_title('Wars')).to eq([star_wars_five, star_wars_four])
    end

    it "returns an empty array if the search term is an empty string" do
      Video.create(title:'The Matrix Reloaded', description:'There is no spoon.')
      expect(Video.search_by_title('')).to eq([])
    end

  end

  describe "review shortcuts" do
    it "should return a value for average_rating" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      first_review = Fabricate(:review, video: video, user: user)
      expect(video.average_rating).to eq(first_review.rating)
    end
  end

end
