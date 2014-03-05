require 'spec_helper'

describe Video do
  it "save itself" do
    video = Video.new(title: "test")
    expect(video).to eq(video)
  end
  it "has many categories" do
    sport = Category.new(name: "sport")
    news = Category.new(name: "news")
    video = Video.new(title: "First Video")
    video.categories << sport
    video.categories << news
    expect(video.categories).to eq [sport,news]
  end
  it "must have title" do
    expect(Video.new(title: nil)).to have(1).errors_on(:title)
  end
  it "must have description" do
    expect(Video.new(description: nil)).to have(1).errors_on(:description)
  end
end
