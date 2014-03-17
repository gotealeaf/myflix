require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "A funny show")
    video.save

    expect(Video.first).to eq(video)
  end

  it "is invalid without a title" do
    monk = Video.create(title: nil, description: "A funny man.")

    expect(monk).to have(1).errors_on(:title)
  end

  it "has description" do
    monk = Video.create(title: "Monk", description: nil)

    expect(monk).to have(1).errors_on(:description)
  end

  it "belongs to category" do
    comedy = Category.create(name: "Comedies")
    futurama = Video.create(title: "Futurama", description: "Future stuff.", category: comedy)

    expect(futurama.category).to eq(comedy)
  end
end