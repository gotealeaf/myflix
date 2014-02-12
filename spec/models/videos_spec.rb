require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Testing", small_cover: "paquito", large_cover: "paquiyo_grande", description: "Paquitez")
    video.save
    expect(Video.first).to eq(video)
  end

  it "has many categories" do
    video = Video.create(title: "Testing_has_cats", small_cover: "paquito_cats", large_cover: "paquiyo_grande_cats", description: "Paquitez_cats")
    
    cat1 = Category.create(name: "Testing_has_cats_1")
    cat2 = Category.create(name: "Testing_has_cats_2")
    
    video.category_ids = [cat1.id, cat2.id]
    expect(video.categories).to eq([cat1, cat2])
  end

  it "does not save a video without a title" do
    video = Video.create(description: "Testing title")
    expect(Video.count).to eq(0)
  end

  it "does not save a video without a title" do
    video = Video.create(title: "Testing title")
    expect(Video.count).to eq(0)
  end
end