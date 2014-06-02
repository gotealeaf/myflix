require 'spec_helper'

describe Video do
  it 'save itself' do
    video = Video.new(title: "Dragon", description: "About a flyng dragon")
    video.save
    # Video.first.title.should == "Dragon"
    expect(Video.first).to eq(video)
  end
  it 'belongs to Category' do  
    action = Category.create(name: "Action")
    dragon = Video.create(title: "Dragon", description: "A dragon story", category: action)
    expect(dragon.category).to eq(action)
  end
  it 'does not save a video without title' do
    video = Video.create(description: "No title")
    expect(Video.count).to eq(0)
  end
  it 'does not save a video without description' do
    video = Video.new(title: "No description")
    video.save
    expect(Video.count).to eq(0)
  end  

end