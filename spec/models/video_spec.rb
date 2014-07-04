require 'spec_helper'

describe Video do
  it "saves itself!" do
    video = Video.new(title: "Bat Man", description: "Gotham needs a hero.")
    video.save
    expect(Video.last).to eq(video)
    
    # Video.first.should == video
    # Video.first.should eq(video)
    # Video.last.title.should == "Bat Man"
  end
end