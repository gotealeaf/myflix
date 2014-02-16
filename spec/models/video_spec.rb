require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "My Cousin Vinny", description: "Cool!")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    drama = Category.create(title: "drama")
    monk = Video.create(title: "monk", description: "Cool!", category: drama)
    expect(monk.category).to eq(drama)
  end

  it "doesn't save a video without a title" do
    video = Video.create(description: "A cool show!")
    expect(Video.count).to eq(0)
  end
it "doesn't save a video without a description" do
  video = Video.create(title: "Rock and Roll")
  expect(Video.count).to eq(0)
end
end