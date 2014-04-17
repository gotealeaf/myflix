require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Robocop", description: "Joel Arvidsson stars as Robocop")
    video.save
    expect(Video.first).to eq(video)
  end
  
  it "has many categories" do
    snowpiercer = Video.create(title: "Snowpiercer", description: "Crazy mindless future")
    action = Category.create(name: "Action")
    drama = Category.create(name: "Drama")
    snowpiercer.categories << action
    snowpiercer.categories << drama
    expect(drama.videos).to include(snowpiercer)
    expect(action.videos).to include(snowpiercer)
  end
  
  it "does not save into database without a title" do
    video = Video.create(description: "Funny one")
    expect(Video.count).to eq(0)
  end
  
  it "does not save into database without a description" do
    description = Video.create(title: "The Goonies")
    expect(Video.count).to eq(0)
  end
end


