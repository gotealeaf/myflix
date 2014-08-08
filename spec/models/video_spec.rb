require 'spec_helper'

describe Video do
  
  it "saves itself" do
    video = Video.new(title: "Bullwinkle", description: "Moose Story")
    video.save
    #Video.first.should == video
    expect(Video.first).to eql(video)

  end 
end
