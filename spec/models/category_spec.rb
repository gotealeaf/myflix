require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Drama")
    category.save

    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    drama = Category.create(name: "Drama")

    monk = Video.create(title: "Monk", description: "A funny show", category: drama)
    southpark = Video.create(title: "South Park", description: "A show about kids.", category: drama)

    expect(drama.videos).to eq([monk, southpark])
  end
end