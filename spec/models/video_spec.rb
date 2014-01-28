require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "great video")
    video.save

    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(name: "dramas")
    monk = Video.create(title: "Monk", description: "a cool video", category: dramas)

    expect(monk.category).to eq(dramas)
  end
end
