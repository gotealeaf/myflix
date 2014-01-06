require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Matrix", description: "A good movie")
    video.save
    expect(Video.first.title).to eq("Matrix")
  end
end
