require 'spec_helper'

describe Video do
  it "Saves a video" do 
    video = Video.new(title: "Monster", description: "This is one of the best movies of 1992", category_id: 1)
    video.save
    video.reload
    expect(Video.first).to eq(video)
  end 
end
