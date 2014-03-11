require "spec_helper"

describe Video do 
  it "saves itself" do
    video = Video.create(title: "monk", description: "a great video")
    expect(Video.first).to eq(video)
  end

  it "has many categories" do
    video = Video.create(title: "monk", description: "a great video")
    cat1 = Category.create(name: "First Category")
    cat2 = Category.create(name: "Second Category")
    video.categories << [cat1, cat2]
    expect(video.categories).to include(cat1, cat2) 
  end
end