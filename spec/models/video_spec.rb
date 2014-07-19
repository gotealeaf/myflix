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

  it "belongs to category" do
    dramas = Category.create(name: "Dramas")
    monk = Video.create(title: "Monk", description: "He's OCD", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  #it "belongs to a category" do
  #  should belong_to(:category)
  #end

end