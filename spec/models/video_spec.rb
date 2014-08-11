require 'spec_helper'

describe Video do
  
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

=begin

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


  it "requires a title" do
    video = Video.new(description: "Moose Story")
    video.save
    expect(Video.count).to eq(0)
  end 

  it "requires a description" do
    video = Video.new(title: "Bullwinkle")
    video.save
    expect(Video.count).to eq(0)
  end 
=end


end
