require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Road Runner", description: "Chased constantly!", small_cover_url: "/tmp/road_runner.jpg", large_cover_url: "/tmp/road_runner_large.jpg", category_id: 1)
    video.save
    expect(Video.first).to eq(video)
    # Video.first.should == video
    # Video.first.should eq(video)
  end

  it "belongs to category" do
    chases = Category.create(name: "Chase movies")
    video = Video.create(title: "Road Runner", description: "Chased constantly!", category: chases)
    expect(video.category).to eq(chases)
  end

  it "is invalid without a title" do
    expect(Video.new(title: nil)).to have(1).errors_on(:title)
    # video = Video.create(description: "a video")
    # expect(Video.count).to eq(0)
  end

  it "is invalid without a description" do
    expect(Video.new(description: nil)).to have(1).errors_on(:description)
    # video = Video.create(title: "a video")
    # expect(Video.count).to eq(0)
  end

end

