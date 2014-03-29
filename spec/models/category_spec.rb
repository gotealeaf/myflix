require 'spec_helper'

describe Category do

  it { should validate_presence_of(:name) }
  it "should validate that length of name is not too long"


  describe 'with proper-format attributes' do
    before { @drama_category = Category.new(name: "drama") }

    it "responds to all attributes" do
      expect(@drama_category).to respond_to(:name)
      expect(@drama_category).to respond_to(:videos)
    end

    it "orders properly" do
      @drama_category.save
      @monk = Video.create(title: "Monk",
                           description: "A forensics show.",
                           sm_cover_locn: "/tmp/monk.jpg",
                           lg_cover_locn: "/tmp/monk_large.jpg",
                           categories: [@drama_category])
      @lie_to_me = Video.create(title: "Lie To Me",
                                description: "An microexpressions tv show.",
                                sm_cover_locn: "/tmp/lie_to_me.jpg",
                                lg_cover_locn: "/tmp/lie_to_me_large.jpg",
                                categories: [@drama_category])

      expect(@drama_category.videos).to eq([@lie_to_me, @monk])
    end

    it "saves into the database exactly" do
      @drama_category.save
      expect(Category.last).to eq(@drama_category)
    end
  end
end
