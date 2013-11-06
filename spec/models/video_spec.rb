require 'spec_helper'


describe Video do
  it "saves itself" do
    video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 2)
  end

  # it "belongs to category" do
  #   category = Category.create(name: 'TV Comedies')
  #   video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
  #   expect(Video.first.category).to eq(category)
  # end

  it { should belong_to(:category) }

  # it "should has a title" do
  #   category = Category.create(name: 'TV Comedies')
  #   video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
  #   expect(Video.first.title).not_to eq(be_nil)
  # end

  it { should validate_presence_of(:title) }

  # it "should has a description" do
  #   category = Category.create(name: 'TV Comedies')
  #   video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
  #   expect(Video.first.description).not_to eq(be_nil)
  # end

  #it { should validate_presence_of(:description) }

end