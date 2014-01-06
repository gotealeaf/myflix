require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Matrix", description: "A good movie")
    video.save
    expect(Video.first.title).to eq("Matrix")
  end

  it "belongs to category" do
    cat = Category.create(name: "TV drama")
    video = Video.create(title: "Monk", description: "A drama", category: cat)

    expect(video.category).to eq(cat)
  end
end
