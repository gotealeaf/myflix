require 'spec_helper'

describe VideoCategory do
  it "saves itself" do
    vidcat = VideoCategory.new(video_id: 1, category_id: 1)
    vidcat.save
    expect(VideoCategory.first).to eq(vidcat)
  end
end

