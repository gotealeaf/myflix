require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video!")
    video.save
    expect(Video.first).to eq(video)
  end

  it "has many categories" do
    dramas = Category.create(name: "Dramas")
    monk = Video.create(title: "Monk", description: "A great show!")
    monk.categories << dramas

    expect(dramas.videos).to include(monk)
  end
end
