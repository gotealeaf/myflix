require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Test video", description: 'This is a really long description video.')
    video.save
    expect(Video.first).to eq(video)
  end
end

describe Video do
  it "has categoies through video" do
    video = Video.create(title: "Test video", description: 'This is a really long description video.')
    category = Category.create(title: 'Scary movies')
    video.category = category
    video.save
    video1 = Video.first
    expect(video.category.title).to eq(category.title)
  end
end
