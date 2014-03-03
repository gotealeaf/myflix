require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.new(title: "Test_Vid", description: "test_vid_description")
    video.save
    # All 3 work, but last is preferred syntax now
    #Video.first.title.should == "Test_Vid"
    #ideo.first.should eq(video)
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    comedies = Category.create(name: "TV Comedies")
    video = Video.create(title: "Futurama", category: comedies)
    expect(video.category).to eq(comedies)
  end
end