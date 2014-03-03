require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.new(title: "Test_Vid", description: "test_vid_description", category_id: 1, small_cover_url: "tmp/small_cover.jpg", large_cover_url: "tmp/large_cover.jpg")
    video.save
    Video.first.title.should == "Test_Vid"
  end
end