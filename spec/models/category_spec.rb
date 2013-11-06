require 'spec_helper'

describe Category do
  it "should has a name" do
    category = Category.create(name: 'TV Comedies')
    category.save
    category.name == 'TV Comedies'
  end

  it "should has many video" do
    category = Category.create(name: 'TV Comedies')
    video1 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video2 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    #Video.where(category: category).size.should > 1
    #binding.pry
    Category.first.videos.size.should == 2
  end
end