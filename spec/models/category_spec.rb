require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: 'Comedy')
    category.save
    expect(Category.first).to eq(category)    
  end

  it "has many videos" do
    comedies = Category.create(name: 'Comedy')
    south_park  = Video.create(title: "South Park", description: "Funny show", category: comedies)
    futurama  = Video.create(title: "Futurama", description: "Another Funny show", category: comedies)
    expect(comedies.videos).to eq([futurama, south_park])
  end

  #it "has many videos" do
  # should have_many(:videos) 
  #end

end

