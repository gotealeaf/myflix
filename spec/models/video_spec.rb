require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry...")
    video.save
    expect(Video.first).to eq(video)
  end
end