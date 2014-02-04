require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(title: "Documentaries")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    scary_movies = Category.create(title: 'Scary movies')
    south_park = Video.create(title: "South Part", description: 'ThiSouth Parkly long description video.', category: scary_movies)
    happy_video = Video.create(title: "Happy Video", description: 'ThiSouth Parkally long description video.', category: scary_movies)
    expect(scary_movies.videos).to eq([south_park, happy_video])
  end
end
