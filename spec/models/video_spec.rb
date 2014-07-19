require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.create(title: 'Tealeaf Story', description: 'The story of Rails')
    video.save
    expect(Video.first).to eq(video)
    #other ways of verifying save
    #Video.first.should == video
    #Video.first.should eq(video)
  end

  it "does not save video without a title" do
    video = Video.create(description: "a good show")
    expect(Video.count).to eq(0)
  end

  it "does not save video without a description" do
    monk = Video.create(title: "Monk")
    expect(Video.count).to eq(0)
  end

  it "belongs to a category" do
    should belong_to(:category)
  end

end