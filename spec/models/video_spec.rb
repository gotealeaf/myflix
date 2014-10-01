require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:title) }
  it { should have_many(:reviews).order("created_at DESC") }
  
  describe "search_by_title" do
    it "returns an empty array if no matches are found" do
      brave_heart= Video.create(title: "brave heart", description: "a good long movie")
      the_brave_soldier = Video.create(title: "the brave soldier", description: "might not even be a movie")
      expect(Video.search_by_title("Invisible")).should eq([])
    end

    it "returns an array of one video for exact match" do 
      brave_heart= Video.create(title: "brave heart", description: "a good long movie")
      the_brave_soldier = Video.create(title: "the brave soldier", description: "might not even be a movie")
      movie = Video.search_by_title("brave heart")
      expect(movie).to eq([brave_heart])
    end

    it "returns an array of one video for a partial match" do
      brave_heart= Video.create(title: "brave heart", description: "a good long movie")
      the_brave_soldier = Video.create(title: "the brave soldier", description: "might not even be a movie")
      movie = Video.search_by_title("eart")
      expect(movie).to eq([brave_heart])
    end

    it "returns an array of movies, ordered by date, that contain the key word" do
      brave_heart = Video.create(title: "brave heart", description: "a good long movie", created_at: 1.day.ago)
      the_brave_soldier = Video.create(title: "the brave soldier", description: "might not even be a movie")
      movies = Video.search_by_title("ave")
      expect(movies).to eq([the_brave_soldier, brave_heart])
    end

    it "returns an empty array for a search of an empty string" do
      brave_heart = Video.create(title: "brave heart", description: "a good long movie")
      the_brave_soldier = Video.create(title: "the brave soldier", description: "might not even be a movie")
      movies = Video.search_by_title("")
      expect(movies).to eq([])
    end
  end

  describe "rating" do
    it "returns an integer of the video's average rating" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, rating: 2)
      review2 = Fabricate(:review, video: video, rating: 5)
      video.rating.should == 3.5
    end

    it "returns 0 if there are no reviews" do 
      video = Fabricate(:video)
      video.rating.should == 0
    end
  end
end
