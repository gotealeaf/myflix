require 'spec_helper'

Video.destroy_all


describe Video do
  it "saves itself" do
    video = Video.new(title: "Godfather", description: "La dolce vita.")
    video.save
    expect(video.title).to eq("Godfather")
  end

  it { should belong_to(:category) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns empty array if no videos found" do
      monk = Video.create(title: "Monk", description: "Show")
      iron_monkey = Video.create(title: "Iron Monkey", description: "Hi-ya!")
      expect(Video.search_by_title("Godfather")).to eq([])
    end
    it "returns array of 1 if one perfect match" do
      monk = Video.create(title: "Monk", description: "Show")
      south_park = Video.create(title: "South Park", description: "Cartoon")
      expect(Video.search_by_title("Monk")).to eq([monk])
    end
    it "returns an array of 1 if one partial match" do
      monk = Video.create(title: "Monk", description: "Show")
      south_park = Video.create(title: "South Park", description: "Cartoon")
      expect(Video.search_by_title("Mon")).to eq([monk])
    end
    it "returns an array ordered by created_at if multiple similar matches" do
      monk = Video.create(title: "Monk", description: "Show")
      iron_monkey = Video.create(title: "Iron Monkey", description: "Hi-ya!")
      expect(Video.search_by_title("Mon")).to eq([iron_monkey, monk])
    end

    it "returns an empty array for an empty search" do
      monk = Video.create(title: "Monk", description: "Show")
      iron_monkey = Video.create(title: "Iron Monkey", description: "Hi-ya!")
      expect(Video.search_by_title("")).to eq([])
    end

  end

  describe "average_review" do
    it "returns N/A if no reviews found" do
      video = Fabricate(:video)
      expect(video.average_review).to eq("N/A")
    end
    
    it "returns number equal to only rating if one review found" do
      video = Fabricate(:video)
      review = Fabricate(:review)
      video.reviews << review
      sum = 0
      video.reviews.each { |review| sum += review.rating}
      average = sum / video.reviews.count
      expect(video.average_review).to eq(average) 
    end

    it "returns number equal to average of multiple ratings if multiple reviews found" do
      video = Fabricate(:video)
      review1 = Fabricate(:review)
      review2 = Fabricate(:review)
      video.reviews << review1 << review2
      sum = 0
      video.reviews.each { |review| sum += review.rating}
      average = sum / video.reviews.count
      expect(video.average_review).to eq(average) 
    end
  end

  describe "order_by_created_at" do
    it "returns an array ordered by created_at if multiple reviews found" do
      video = Fabricate(:video)
      review1 = Fabricate(:review)
      review2 = Fabricate(:review)
      video.reviews << review1 << review2
      sum = 0
      video.reviews.each { |review| sum += review.rating}
      average = sum / video.reviews.count
      expect(video.reviews.order_by_created_at).to eq([review2, review1])
    end

  end

end
