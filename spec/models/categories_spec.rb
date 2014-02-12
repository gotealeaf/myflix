require 'spec_helper'

describe Category do
  it "saves itself" do
    cat = Category.new(name: "cat_test")
    cat.save
    expect(Category.find(cat.id)).to eq(cat)
  end

  it "has many videos" do
    cat = Category.create(name: "many videos")

    the_wire = Video.create(title: "The Wire", description: "A Baltimore's portrait", category_ids: cat.id)
    sopranos = Video.create(title: "The Soprano", description: "Mafia", category_ids: cat.id)

    expect(cat.videos).to include(sopranos, the_wire)
  end
end