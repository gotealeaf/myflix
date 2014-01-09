require 'spec_helper'

describe Category do
  it "counts many videos" do
    category = Category.create(name: 'Animated')
    category.videos.create(title: "up", description: 'good')
    category.videos.create(title: "down", description: 'bad')
    expect(category.videos.count).to eq(2)
  end

it "has many videos" do
    animated = Category.create(name: 'Animated')
    up = Video.create(title: "up", category: animated, description: 'good')
    down = Video.create(title: "down", category: animated, description: 'bad')
  
    expect(animated.videos).to eq([down,up])
  end

  it {should have_many(:videos)}

end
