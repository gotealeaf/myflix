require 'spec_helper'

describe Category do
  it "saves itself" do
    video = Video.new(title: "Test video", description: 'This is a really long description video.')
    video.save
    expect(Video.first).to eq(video)
  end
