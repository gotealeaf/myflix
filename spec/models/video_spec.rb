require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Jurassic Park", description: "classic movie for sure")
    video.save
    expect(Video.first).to eq(video)
  end

  it 'belongs to category' do
    action = Category.create(name: "Action Thriller")
    video = Video.create(title: "Transformer", description: "WOW, great", category: action)
    expect(video.category).to eq(action)
  end
  
end