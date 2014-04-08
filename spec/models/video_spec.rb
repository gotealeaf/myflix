require 'pry'
require 'spec_helper'

describe Video do
  it { should have_many(:categories).through(:video_categories) }
  it { should validate_presence_of :title}
  it { should validate_presence_of :description}

  describe "search_by_title" do
      
    before(:each) do
      @sport_1 = Video.create(title: "sport_1", description: "x", created_at: 1.day.ago)
      @sport_2 = Video.create(title: "sport_2", description: "x")
      @news_1 = Video.create(title: "social news", description: "x")
    end

    it "returns [] when no match"  do
      expect(Video.search_by_title("gossip")).to eq []
    end
    
    it "returns one element array for single exact match" do
       expect(Video.search_by_title("sport_1")).to eq [@sport_1]
    end
    it "returns one element array for single partial match" do
       expect(Video.search_by_title("news")).to eq [@news_1]
    end
    it "returns matched element array for mutiple matchs by order of created time" do
       expect(Video.search_by_title("sport")).to eq [@sport_2, @sport_1]
    end
    it "returns [] for empty search" do
      expect(Video.search_by_title(" ")).to eq []
    end
  end

  describe "number of reviews" do
    it "returns number of reviews when more than one review" do
      @video = Fabricate(:video) do
        reviews(count: 5) {
          Fabricate.build(:review, user: nil)
        }
      end
      expect(@video.number_of_reviews).to eq 5
    end
    it "returns zero when no reviews" do
      @video = Fabricate(:video)
      expect(@video.number_of_reviews).to eq 0
    end
  end

  describe "averge rating" do
    it "return averge rating when more than one reviews" do
      # @video =  Fabricate(:video) { 
      #   reviews(count: 2){ 
      #     Fabricate(:review)  
      #   }
      # }
      
#       averge = @video.reviews.map(&:rating).sum / @video.reviews.count

    @video = Fabricate(:video)

    #why this faile ???? QQ
#     @test = Fabricate(:review_no_video, rating: 34, video: @video)
    Fabricate(:review, video: @video, rating: 2)
#     @video.reviews << Fabricate(:review, video: nil, rating: 2)
    Fabricate(:review, video: @video, rating: 3)

    expect(@video.averge_rating).to eq(2.5) 
    end
  end
end


  
