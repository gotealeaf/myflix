require 'spec_helper'

describe Video do
  
  it "saves itself" do
    video = Video.new(title: "Bullwinkle", description: "Moose Story")
    video.save
    expect(Video.first).to eq(video)
  end 

  it "knows its category" do
    cartoon = Category.create(name: "Cartoon")
    winkle = Video.create(title: "Bullwinkle", description: "Moose Story", category: cartoon)
    expect(Video.first.category).to eq(Category.first)
  end 






end
