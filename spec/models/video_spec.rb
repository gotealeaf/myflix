require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Shark Tank", description: "A great entrepreneurial show")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(name: "Dramas")
    monk = Video.create(title: "Monk", description: "A detective show", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "requires a title" do
    video = Video.new(description: "A description without a title")
    video.save
    expect(Video.first).to be_nil
  end

  it "requires a description" do
    video = Video.new(title: "A video without a description")
    video.save
    expect(Video.first).to be_nil
  end
end