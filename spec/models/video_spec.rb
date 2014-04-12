require 'spec_helper'

describe Video do
  #it { should have_many(:queue_items)}
  it { should have_many(:categories) }  #WANT BOTH IN TESTING???
  it { should have_many(:categories).through(:video_categories) }
  it { should have_many(:reviews).order("created_at DESC")}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description)}

  let(:video) { Fabricate(:video, title: "Family Guy") }


  describe 'with valid attributes'do

    it "responds to all attributes" do
      expect(video).to respond_to(:title)
      expect(video).to respond_to(:description)
      expect(video).to respond_to(:small_cover)
      expect(video).to respond_to(:large_cover)
      expect(video).to respond_to(:categories)
      expect(video).to respond_to(:reviews)
    end
    it "saves into the database exactly" do
      video.save
      expect(Video.last).to eq(video)
    end
    it "orders categories properly" do
      @comedy_category = Category.create(name: "Comedy", videos: [video])
      @cartoon_category = Category.create(name: "Cartoons", videos: [video])

      expect(video.categories).to eq([@cartoon_category, @comedy_category])
    end
  end

  #DESIGNED WITH TDD APPROACH
  describe "searche_by_title" do
    before { video.save }

    it "returns an empty array when it doesn't find a title that matches" do
      @false_title = "falsevideo"
      expect(Video.search_by_title(@false_title)).to eq([])
    end
    it "returns an array of the match when it finds a video with an exact match to the title provided" do
      @real_title = "Family Guy"
      expect(Video.search_by_title(@real_title)).to eq([video])
    end
    # Note that it also orders them in rev-chronological, tho not a business req
    it "returns an array of the matches when it finds videos with a partial match to the title provided" do
      @family_guy_sequel = video.dup
      @family_guy_sequel.description = "Sequel to the other family guy video."
      @family_guy_sequel.save
      @partial_title = "Family"
      expect(Video.search_by_title(@partial_title)).to eq([@family_guy_sequel, video])
    end
    it "returns nothing for an empty string" do
      expect(Video.search_by_title("")).to eq([])
    end
  end

  describe "average_rating" do

    it "returns nil if there are no ratings" do
      vid = Fabricate(:video)
      expect(vid.average_rating).to eq(nil)
    end
    it "returns the float average of the ratings if there are one or more ratings" do
      vid     = Fabricate(:video, id: 99)
      review1 = Fabricate(:review, rating: 2, video: vid, user: Fabricate(:user))
      review2 = Fabricate(:review, rating: 4, video: vid, user: Fabricate(:user))
      expect(vid.average_rating).to eq(3)
      expect(vid.average_rating).to be_kind_of(Float)
    end
  end
end
