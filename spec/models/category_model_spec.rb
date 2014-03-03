require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: "TV Comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    category = Category.new(name: "TV Comedies")
    category.save
    Video.create(category_id: 1)
    Video.create(category_id: 1)
    expect(Category.first.videos.length).to eq(2)
  end
end