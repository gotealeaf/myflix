require 'spec_helper'

describe VideoCategory do 
  it "saves itself" do
    video_category = VideoCategory.new(video_id: 18, category_id: 7)
    video_category.save
    expect(VideoCategory.first).to eq(video_category)
  end
end

