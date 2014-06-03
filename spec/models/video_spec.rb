require 'rails_helper'

describe Video do
  it "saves itself" do 
    video = Video.new(title: "Futurama", description: "Great Comedy", small_cover_url: "futurama")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do 
    comedy = Category.create(name: "comedy")
    south_park = Video.create(title: "South Park", description: "Best Comedy", category: comedy)
    expect(south_park.category).to eq(comedy)
  end
end