require 'spec_helper'

describe Video do
  it { should have_many(:categories) }  #WANT BOTH IN TESTING???
  it { should have_many(:categories).through(:video_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description)}

  before do
    @family_guy_video = Video.new(title: "Family Guy",
                                  description: "A video in db.",
                                  sm_cover_locn: "/tmp/family_guy.jpg",
                                  lg_cover_locn: "/tmp/family_guy_large.jpg")
  end


  describe "with wrong-format attributes" do
    it "is not valid with too long of a title"
    it "is not valid with a small cover file/location that cannot be found"
    it "is not valid wiht a large cover file/location that cannot be found"
  end


  describe 'with valid attributes'do


    it "responds to all attributes" do
      expect(@family_guy_video).to respond_to(:title)
      expect(@family_guy_video).to respond_to(:description)
      expect(@family_guy_video).to respond_to(:sm_cover_locn)
      expect(@family_guy_video).to respond_to(:lg_cover_locn)
      expect(@family_guy_video).to respond_to(:categories)
    end
    it "saves into the database exactly" do
      @family_guy_video.save
      expect(Video.last).to eq(@family_guy_video)
    end
    it "orders categories properly" do
      @comedy_category = Category.create(name: "Comedy", videos: [@family_guy_video])
      @cartoon_category = Category.create(name: "Cartoons", videos: [@family_guy_video])

      expect(@family_guy_video.categories).to eq([@cartoon_category, @comedy_category])
    end
  end

  #DESIGNED WITH TDD APPROACH
  describe "searche_by_title" do
    before { @family_guy_video.save }

    it "returns an empty array when it doesn't find a title that matches" do
      @false_title = "falsevideo"
      expect(Video.search_by_title(@false_title)).to eq([])
    end

    it "returns an array of the match when it finds a video with an exact match to the title provided" do
      @real_title = "Family Guy"

      expect(Video.search_by_title(@real_title)).to eq([@family_guy_video])
    end

    # Note that it also orders them in rev-chronological, tho not a business req
    it "returns an array of the matches when it finds videos with a partial match to the title provided" do
      @family_guy_sequel = @family_guy_video.dup
      @family_guy_sequel.description = "Sequel to the other family guy video."
      @family_guy_sequel.save

      @partial_title = "Family"
      expect(Video.search_by_title(@partial_title)).to eq([@family_guy_sequel, @family_guy_video])
    end

    it "returns nothing for an empty string" do
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
