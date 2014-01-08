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

  it "fails validation with no title" do
     expect(Video.new).to have(1).errors_on(:title)
  end

  it "fails validation with no description" do
    expect(Video.new).to have(1).errors_on(:description)
  end

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
