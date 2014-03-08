require "spec_helper"

describe Category do
  it "saves itself" do
    category = Category.new(name: "Animation")
    category.save
    Category.first.name.should == "Animation"
  end

  it "has many videos" do
    category = Category.create(name: "Animation")

    video_frozen = category.videos.create(
      title: "Frozen",
      description: "Frozen is a 2013 American 3D computer-animated musical fantasy-comedy film produced by Walt Disney Animation Studios and released by Walt Disney Pictures.",
      small_cover_url: "http://localhost:3000/tmp/frozen.jpg",
      large_cover_url: "http://localhost:3000/tmp/frozen_large.jpg"
    )

    video_futurama = category.videos.create(
      title: "Futurama",
      description: "Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. Cohen for the Fox Broadcasting Company. The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century. The series was envisioned by Groening in the late 1990s while working on The Simpsons, later bringing Cohen aboard to develop storylines and characters to pitch the show to Fox.",
      small_cover_url: "http://localhost:3000/tmp/futurama.jpg",
      large_cover_url: "http://localhost:3000/tmp/futurama_large.jpg"
    )

    category.videos.should include(video_frozen, video_futurama)
  end
end
