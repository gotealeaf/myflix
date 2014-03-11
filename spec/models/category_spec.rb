require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: "Comedy")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "Comedy")
    south_park = Video.create(title: "South Park", description: "Funny show!")
    futurama = Video.create(title: "Futurama", description: "Funny show!")
    south_park.categories << comedies
    futurama.categories << comedies
    expect(comedies.videos).to include(south_park, futurama)
  end
end