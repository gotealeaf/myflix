require 'spec_helper'

describe Category do
  it "has many videos" do
    cat = Category.create(name: "TV drama")
    monk = Video.create(title: "Monk", description: "A drama", category: cat)
    family_guy = Video.create(title: "Family guy", description: "balabala", category: cat)

    expect(cat.videos).to include(monk, family_guy)
  end
end
