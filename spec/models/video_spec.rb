require 'spec_helper'

describe Video do


  describe 'created normally but' do
    before { @normal_video = Video.new(title: "Stock Title",
                                       description: "Generic Descriptio ",
                                       sm_cover_locn: "/tmp/stock_title.jpg",
                                       lg_cover_locn: "/tmp/stock_title_large.jpg")}

    describe "with missing title" do
      before { @normal_video.title = "" }
      it "is not valid" do
        expect(@normal_video).to_not be_valid
      end
    end

    describe "with missing description" do
      before { @normal_video.description = "" }
      it "is not valid" do
        expect(@normal_video).to_not be_valid
      end
    end
    it "is not valid if sm_cover_locn is missing"
    it "is not valid if lg_cover_locn is missing"
  end


  describe "with wrong-format attributes" do
    it "is not valid with too long of a title"
    it "is not valid with a small cover file/location that cannot be found"
    it "is not valid wiht a large cover file/location that cannot be found"
  end


  describe 'with valid attributes'do
    before do
      @family_guy_video = Video.new(title: "Family Guy",
                                    description: "A video in db.",
                                    sm_cover_locn: "/tmp/family_guy.jpg",
                                    lg_cover_locn: "/tmp/family_guy_large.jpg")
    end

    it "responds to all attributes" do
      expect(@family_guy_video).to respond_to(:title)
      expect(@family_guy_video).to respond_to(:description)
      expect(@family_guy_video).to respond_to(:sm_cover_locn)
      expect(@family_guy_video).to respond_to(:lg_cover_locn)
      expect(@family_guy_video).to respond_to(:categories)
    end
    it "is valid" do
      expect(@family_guy_video).to be_valid
    end
    it "saves into the database properly" do
      @family_guy_video.save
      expect(Video.first).to eq(@family_guy_video)
    end
    it "orders categories properly" do
      @comedy_category = Category.create(name: "Comedy", videos: [@family_guy_video])
      @cartoon_category = Category.create(name: "Cartoons", videos: [@family_guy_video])

      expect(@family_guy_video.categories).to eq([@cartoon_category, @comedy_category])
    end
  end
end

