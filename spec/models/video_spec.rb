require "spec_helper"

describe Video do
  it "saves itself" do
    video = Video.new(
      title: "Frozen",
      description: "Frozen is a 2013 American 3D computer-animated musical fantasy-comedy film produced by Walt Disney Animation Studios and released by Walt Disney Pictures.",
      small_cover_url: "http://localhost:3000/tmp/frozen.jpg",
      large_cover_url: "http://localhost:3000/tmp/frozen_large.jpg"
    )
    video.save
    Video.first.title.should == "Frozen"
  end

  it "belongs to a category" do
    video = Video.new(
      title: "Frozen",
      description: "Frozen is a 2013 American 3D computer-animated musical fantasy-comedy film produced by Walt Disney Animation Studios and released by Walt Disney Pictures.",
      small_cover_url: "http://localhost:3000/tmp/frozen.jpg",
      large_cover_url: "http://localhost:3000/tmp/frozen_large.jpg"
    )

    category_animation = video.create_category(name: "Animation")

    video.category.should == category_animation
  end
end
