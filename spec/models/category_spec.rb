require 'spec_helper'

describe Category do

  it 'should save itself' do
    category = Category.new(title: "Horror")
    category.save
    Category.first.title.should.should == "Horror"
  end

  it "has many videos" do
    drama = Category.create(title: "drama")
    monk = Video.create(title: "monk", description: "Cool!", category: drama)
    foobar = Video.create(title: "foobar", description: "Cooler!",category: drama)
    expect(drama.videos).to include(monk, foobar)
  end
end