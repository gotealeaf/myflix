require 'spec_helper'

#tests saving to the test database
describe Video do
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video!")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(name: "dramas")
    monk = Video.create(title: "monk", description: "a great video", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "a great video!")
    expect(Video.count).to eq(0)
  end
  it "does not save a video without a description" do
    video = Video.create(title: "monk")
    expect(Video.count).to eq(0)
  end
end