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

  it"is invalid without a title"do
    expect(Video.new(title: nil, description: "a great video!")).to have(1).errors_on(:title)
  end

  it"is invalid without a description"do
    expect(Video.new(description: nil, title: "Monk")).to have(1).errors_on(:description)
  end
end