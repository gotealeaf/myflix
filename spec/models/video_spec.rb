require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews)}

  describe ".search_by_title(search_term)" do

     it "should return an empty array if the user submits no parameters" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      expect(Video.search_by_title("")).to eq([])
    end

    it "should return an empty array if it finds no videos" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      expect(Video.search_by_title("test")).to eq([])
    end

    it "should return an array of one video if it is an exact match" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      expect(Video.search_by_title("South Park")).to eq([south_park])
    end

    it "should return an array of one video for a partial match" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      south_park = Video.create(title: "South Park", description: "A funny video")
      family_guy_2 = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons")
      expect(Video.search_by_title("Family Guy")).to eq([family_guy, family_guy_2])
    end
    it "should return an array of all matches oredered by created_at" do
      family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "A funny video", created_at: 2.day.ago)
      family_matters = Video.create(title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 3.day.ago)
      expect(Video.search_by_title("Family")).to eq([family_guy, family_matters])
    end 
  end

  describe '#recent_reviews' do
    it "should return reviews by order of their creation date" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, rating: 3.5, created_at: 1.day.ago, video: video)
      review2 = Fabricate(:review, rating: 4.5, created_at: 2.day.ago, video: video)
      expect(video.recent_reviews).to eq([review1, review2])
    end
    it "should return all reviews if there are less than eight" do
      video = Fabricate(:video)
      review4 = Fabricate(:review, rating: 4.5, created_at: 4.day.ago, video: video)
      review5 = Fabricate(:review, rating: 3.5, created_at: 5.day.ago, video: video)
      review1 = Fabricate(:review, rating: 3.5, created_at: 1.day.ago, video: video)
      review2 = Fabricate(:review, rating: 4.5, created_at: 2.day.ago, video: video)
      review3 = Fabricate(:review, rating: 3.5, created_at: 3.day.ago, video: video)
      review6 = Fabricate(:review, rating: 4.5, created_at: 6.day.ago, video: video)
      review7 = Fabricate(:review, rating: 3.5, created_at: 7.day.ago, video: video)
      review8 = Fabricate(:review, rating: 4.5, created_at: 8.day.ago, video: video)
      expect(video.recent_reviews).to eq([review1, review2, review3, review4, review5, review6, review7, review8])
    end
    it "should return only eight reviews if there are more than eight" do
      video = Fabricate(:video)
      review4 = Fabricate(:review, rating: 4.5, created_at: 4.day.ago, video: video)
      review5 = Fabricate(:review, rating: 3.5, created_at: 5.day.ago, video: video)
      review1 = Fabricate(:review, rating: 3.5, created_at: 1.day.ago, video: video)
      review2 = Fabricate(:review, rating: 4.5, created_at: 2.day.ago, video: video)
      review3 = Fabricate(:review, rating: 3.5, created_at: 3.day.ago, video: video)
      review6 = Fabricate(:review, rating: 4.5, created_at: 6.day.ago, video: video)
      review9 = Fabricate(:review, rating: 4.5, created_at: 9.day.ago, video: video)
      review10 = Fabricate(:review, rating: 4.5, created_at: 10.day.ago, video: video)
      review7 = Fabricate(:review, rating: 3.5, created_at: 7.day.ago, video: video)
      review8 = Fabricate(:review, rating: 4.5, created_at: 8.day.ago, video: video)
      expect(video.recent_reviews).to eq([review1, review2, review3, review4, review5, review6, review7, review8])
    end
    it "should return the most recent eight reviews" do
      video = Fabricate(:video)
      review4 = Fabricate(:review, rating: 4.5, created_at: 4.day.ago, video: video)
      review5 = Fabricate(:review, rating: 3.5, created_at: 5.day.ago, video: video)
      review1 = Fabricate(:review, rating: 3.5, created_at: 1.day.ago, video: video)
      review2 = Fabricate(:review, rating: 4.5, created_at: 2.day.ago, video: video)
      review3 = Fabricate(:review, rating: 3.5, created_at: 3.day.ago, video: video)
      review6 = Fabricate(:review, rating: 4.5, created_at: 6.day.ago, video: video)
      review9 = Fabricate(:review, rating: 4.5, created_at: 9.day.ago, video: video)
      review10 = Fabricate(:review, rating: 4.5, created_at: 10.day.ago, video: video)
      review7 = Fabricate(:review, rating: 3.5, created_at: 7.day.ago, video: video)
      review8 = Fabricate(:review, rating: 4.5, created_at: 8.day.ago, video: video)
      expect(video.recent_reviews).to eq([review1, review2, review3, review4, review5, review6, review7, review8])
    end
    it "should return an empty array if the video does not have any reviews" do
      video = Fabricate(:video)
      expect(video.recent_reviews).to eq([])
    end
  end

  describe '#average_rating' do

    it "should return the rating of a video's review if there is only one" do
      video = Fabricate(:video)
      review = Fabricate(:review, rating: 4.5, video: video)

      expect(video.average_rating).to eq(4.5)
    end

    it "should average the ratings from a video's reviews if there are more than one review" do
      video = Fabricate(:video)
      review = Fabricate(:review, rating: 4.5, video: video)
      review2 = Fabricate(:review, rating: 5.0, video: video)

      expect(video.average_rating).to eq(4.75)
    end

  end
end


