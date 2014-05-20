require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry...")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    action = Category.create(name: "Action")
    monk = Video.create(title: "Monk", description: "a great video!", category_id: action.id)
    expect(monk.category).to eq(action)
  end
end