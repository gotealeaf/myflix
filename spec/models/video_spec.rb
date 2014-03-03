require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.new(title: "Test_Vid", description: "test_vid_description")
    video.save

    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    comedies = Category.create(name: "TV Comedies")
    video = Video.create(title: "Futurama", category: comedies)
    expect(video.category).to eq(comedies)
  end

  it "requires a title to save" do
    video = Video.create(description: "video with no title")
    expect(Video.count).to eq(0)
  end

  it "requires a description to save" do
    video = Video.create(title: "video with no description")
    expect(Video.count).to eq(0)
  end
end