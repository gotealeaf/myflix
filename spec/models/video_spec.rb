require 'spec_helper'

describe Video do
  it "describes itself" do
    video = Video.new(title: "Monk", description: "great video")
    video.save

    expect(Video.first).to eq(video)
  end
end
