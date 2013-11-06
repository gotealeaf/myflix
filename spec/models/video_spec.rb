require 'spec_helper'


describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 2)
    video.save
    Video.first.title.should == "Monk"
  end
  it "belongs to category" do
    category = Category.create(name: 'TV Comedies')
    video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    Video.first.category.should == category
  end
end