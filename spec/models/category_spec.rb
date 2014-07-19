require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: 'Comedy')
    category.save
    expect(Category.first).to eq(category)    
  end

  it "has many videos" do
   should have_many(:videos) 
  end

end

