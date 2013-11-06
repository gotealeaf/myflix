require 'spec_helper'


describe Video do
  it "saves itself" do
    video = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category_id: 2)
    Video.first.title.should == "Monk"
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

  it { should validate_presence_of(:description) }

  it "returns empty array if no match in search result" do
    monk = Video.create(title: "Monk", description: "This is monk movie")
    expect(Video.search_by_title("family")).to eq([])
  end

  it "returns one array if there is 1 match" do
    monk = Video.create(title: "Monk", description: "This is monk movie")
    futurama = Video.create(title: "Futurama", description: "This is futurama movie")
    expect(Video.search_by_title("Monk")).to eq([monk])
    #binding.pry
  end

  # it "returns many record if search result is many" do
  #   video = Video.create(title: "Monk", description: "This is monk movie")
  #   video = Video.create(title: "Monk 2", description: "This is monk movie")
  #   result << Video.search_by_title("Monk")
  # end
end