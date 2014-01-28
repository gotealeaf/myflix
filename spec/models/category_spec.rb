require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Sports")
    category.save

    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    sports = Category.create(name: "Sports")
    south_park = Video.create(title: "South Park", description: "A funny show", category: sports)
    futurama = Video.create(title: "Futurama", description: "Another funny show", category: sports)

    expect(sports.videos).to eq([futurama, south_park])
  end


end
