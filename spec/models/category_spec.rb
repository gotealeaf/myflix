require 'spec_helper'

describe Category do
  it "can has many videos" do
    sport = Category.new(name: "sport")
    video1 = Video.new(title: "First Video")
    video2 = Video.new(title: "Second Video")
    video3 = Video.new(title: "Third Video")
    sport.videos << video1
    sport.videos << video2
    expect(sport.videos).to eq [video1,video2]
  end
end
