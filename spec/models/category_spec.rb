require 'spec_helper'

describe Category do
  it "saves itslef" do
    category = Category.new(name: 'Category')
    category.save
    Category.first.name.should == 'Category'
  end

  it "has_many videos" do
    should have_many(:videos)
  end
end