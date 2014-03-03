require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: "TV Comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "TV Comedies")
    # doing the same thing, multiple ways
    south_park = Video.create(title: "South Park", description: "haha", category: comedies)
    futurama = Video.create(title: "Futurama", description: "Fry", category: comedies)
    # different tests:
    expect(Category.first.videos.length).to eq(2)
    expect(comedies.videos).to include(futurama, south_park)
    # only with order: :title in place in category model
    expect(comedies.videos).to eq([futurama, south_park])
  end
end