require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.create(title: 'Up', description: "Old man and boy have an adventure when his house floats away.")
    # video = Video.new(title: 'Up', description: "Old man and boy have an adventure when his house floats away.")
    video.save
   expect(Video.first).to eq(video)
  end 

   it "belongs to a category" do
    animated = Category.create(name: 'Animated')
    video = Video.create(title: 'Up', category: animated)
    expect(video.category).to eq(animated)
  end

 
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should belong_to(:category)}

end
