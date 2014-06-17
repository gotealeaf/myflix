require 'rails_helper'

describe Genre do
  it "saves to database" do
    genre = Genre.new(name: 'comedy', slug: 'comedy')
    genre.save

    expect(Genre.first).to eq(genre)
  end

  it "has many videos" do
    genre = Genre.create(name: 'action')
    video_1 = Video.create(name: 'gladiator', description: 'About gladiators', genre: genre)
    video_2 = Video.create(name: 'terminator', description: 'About robots', genre: genre)
    expect(Video.where(genre: genre).count).to eq(2)
    expect(genre.videos).to eq([video_1, video_2])
  end
end
