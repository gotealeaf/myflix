require 'spec_helper'

describe Catetory do

  describe 'with missing attributes' do
    before { @empty_category = Category.new }

    it "is not valid if name is missing" do
      expect(@empty_category).to_not be_valid
    end
  end


  describe 'with wrong-format attributes' do
    it 'is not valid if name is too long'
  end


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

    it "saves properly" do
      @drama_category.save
      expect(Category.first).to eq(@drama_category)
    end
  end
end
