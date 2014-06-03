require 'rails_helper'

describe Category do 
  it "saves itself" do 
    cat = Category.new(name: "Comedy")
    cat.save
    expect(Category.first).to eq(cat)
  end

  it "has many videos" do 
    comedy = Category.create(name: "Comedy")  
    south_park = Video.create(title: "South Park", description: "The Best Comedy", category: comedy)
    futurama = Video.create(title: "Futurama", description: "Another Great Comedy", category: comedy)
    expect(comedy.videos).to eq([futurama, south_park])
  end
end