require 'spec_helper'

describe Category do
  it "saves itself" do
    video = Video.new(title: "Test video", description: 'This is a really long description video.')
    video.save
    Video.first.title.should == "Test video"
    Video.first.description.should == 'This is a really long description video.'
  end
end
