require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "comedies")
    south_park = Video.create(title: "South Park", description: "Funny video!", category: comedies)
    futurama = Video.create(title: "Futurama", description: "Space travel!", category: comedies)
    expect(comedies.videos).to include(south_park, futurama)
  end
end