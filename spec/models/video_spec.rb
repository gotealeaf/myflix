require 'spec_helper'

describe Video do 
  it "saves itself" do 
    video = Video.new(
                    title: "Family Guy", 
                    description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
                    small_cover_url: "/tmp/family_guy.jpg"
                    )
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    comedy = Category.create(name: "Comedy")
    vid1 = Video.create(
            title: "Comedy1", 
            description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy.jpg",
            category: comedy
            )
    expect(vid1.category).to eq(comedy)
  end

  it "has has to have title before saving" do
    vid1 = Video.create(
            description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy.jpg"
            )
    expect(Video.count).to eq(0)
  end

  it "has has to have description before saving" do
    vid1 = Video.create(
            title: "Comedy1", 
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy.jpg"
            )
    expect(Video.count).to eq(0)
  end
end

