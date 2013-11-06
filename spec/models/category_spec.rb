require 'spec_helper'

describe Category do
  # it "should has a name" do
  #   category = Category.create(name: 'TV Comedies')
  #   category.save
  #   expect(category.name).to eq('TV Comedies')
  # end

  it { should validate_presence_of(:name) }

  # it "should has many video" do
  #   category = Category.create(name: 'TV Comedies')
  #   video1 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
  #   video2 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
  #   expect(Category.first.videos.size).to eq(2)
  # end

  it { should have_many(:videos) }

end