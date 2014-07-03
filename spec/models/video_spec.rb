require 'spec_helper'

describe Video do
  it "saves itself!" do
    video = Video.new(title: "Bat Man", description: "Gotham needs a hero.")
    video.save
    Video.last.title.should == "Bat Man"
  end
end