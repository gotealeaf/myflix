require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { validate_presence_of(:title) }
  it { should validate_presence_of(:description) } 
  it { should have_many(:reviews).order("created_at DESC")}


  describe "search_by_title" do
    it "returns an empty array if there is no video" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("lost")).to eq([])
    end
    
    it "returns an array with one video if there an exact match" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("family guy")).to eq([f_guy])
    end

    it "returns an array with one video if there a partial match" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("guy")).to eq([f_guy])
    end

    it "returns an array all matches orderd by created_at" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow", created_at: 1.day.ago)
      expect(Video.search_by_title("family")).to eq([f_guy, f_feud])
    end

    it "returns an empty array if the search is an empty string" do
      f_guy = Video.create(title: "Family Guy", description:"Funny show")
      f_feud = Video.create(title: "Family Feud", description:"Gameshow")
      expect(Video.search_by_title("")).to eq([])
    end
  end

  describe "calculate_rating" do
    before { @monk = Fabricate(:video) }
    context "video with reviews" do
      before do
        review1 = Fabricate(:review, video_id: @monk.id, rating: 5)
        review2 = Fabricate(:review, video_id: @monk.id, rating: 3)
        review3 = Fabricate(:review, video_id: @monk.id, rating: 4)
      end

      it "returns the average rating of all of a videos reviews" do
        expect(@monk.calculate_rating).to eq(4.0)
      end

      it "returns the rating rounded to one decimal place" do
        review4 = Fabricate(:review, video_id: @monk.id, rating: 5)
        expect(@monk.calculate_rating).to eq(4.3)
      end
    end

    context "video with no reviews" do
      it "returns not yet rated message" do
        expect(@monk.calculate_rating).to be_a(String)
      end
    end
  end 
end










