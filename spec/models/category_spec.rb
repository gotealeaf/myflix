require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(title: "Documentaries")
    category.save
    expect(Category.first).to eq(category)
  end
end

describe Category do
  it "has videos asociated" do
    video = Video.create(title: "Test video", description: 'This is a really long description video.')
    category = Category.create(title: 'Scary movies')
    video.category = category
    video.save
    expect(category.videos.first).to eq(video)
  end
end
