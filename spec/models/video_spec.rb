require 'rails_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "monk", description: "I like this video")
    video.save
    expect(Video.first).to eq(video)
  end
end