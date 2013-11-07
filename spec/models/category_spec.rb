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

  it "should show all the video if the result is less than 6 videos in reverse order" do
    category = Category.create(name: 'TV Comedies')
    video1 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video2 = Video.create(title: "Monk2", description: "This is monk 2 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video3 = Video.create(title: "Monk3", description: "This is monk 3 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video4 = Video.create(title: "Monk4", description: "This is monk 4 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video5 = Video.create(title: "Monk5", description: "This is monk 5 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    expect(Category.recent_video(category)).to eq([video5, video4, video3, video2, video1])
  end

  it "should show only six videos if the result is more than six videos in reverse order" do
    category = Category.create(name: 'TV Comedies')
    video1 = Video.create(title: "Monk", description: "This is monk video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video2 = Video.create(title: "Monk2", description: "This is monk 2 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video3 = Video.create(title: "Monk3", description: "This is monk 3 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video4 = Video.create(title: "Monk4", description: "This is monk 4 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video5 = Video.create(title: "Monk5", description: "This is monk 5 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video6 = Video.create(title: "Monk6", description: "This is monk 6 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    video7 = Video.create(title: "Monk7", description: "This is monk 7 video description", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: category)
    expect(Category.recent_video(category)).to eq([video7, video6, video5, video4, video3, video2])
  end

end