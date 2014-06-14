require 'rails_helper'

describe Video do
  it "saves itself" do 
    video = Video.new(title: "Highway to Rails", description: "A fast paced thriller with plenty of feel-good moments.")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to a category" do
    drama = Category.create(name: "Drama")
    monk = Video.create(title: "Monk", description: "Not my cup of tea, but to each his own.", category: drama)
    expect(monk.category).to eq(drama)
  end
end