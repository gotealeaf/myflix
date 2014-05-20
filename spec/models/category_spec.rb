require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Comedy")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedy = Category.create(name: "Comedy")
    futurama = Video.create(title: "Futurama", description: "Space travel!", category: comedy)
    south_park = Video.create(title: "South Park", description: "Funny video!", category: comedy)
    expect(comedy.videos).to include(south_park, futurama)   
  end
end