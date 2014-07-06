require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Godfather", description: "La dolce vita.")
    video.save
    expect(video.title).to eq("Godfather")
  end

  it { should belong_to(:category) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }


  # it "belongs to category" do
  #   temple_doom = Video.new(title: "Temple of Doom", description: "Putting the India in Indiana Jones.")
  #   temple_doom.save
  #   lucas = Category.new(name: "George Lucas")
  #   lucas.videos << temple_doom
  #   expect(lucas.videos.first).to eq(temple_doom)
  # end

  # it "validates title" do
  #   golf_movie = Video.new(description: "Cannot remember title but it has a gopher and that funny lookin guy with big eyes.")
  #   golf_movie.should_not be_valid
  # end

  # it "validates description" do
  #   golf_movie = Video.new(title: "Caddyshack")
  #   golf_movie.should_not be_valid
  # end


end
