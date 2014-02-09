require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe Category do

  it { should have_many(:videos) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "#display_most_recent_videos" do
    it 'returns an empty array if there are no videos' do
      category = Category.create(title: 'Animation', description: "This is for drawn shows." )
      expect(Category.first.display_most_recent_videos).to eq([])
    end
    it 'returns an array of one video if there is only one video' do
      category = Category.create(title: 'Animation', description: "This is for drawn shows." )
      video = Video.create(title: 'The Simpsons', description: "This is a show about a family.")
      video.category = category
      video.save
      expect(category.display_most_recent_videos).to eq([video])
    end
    it 'returns an array of the no more than 6 videos' do
      category = Category.create(title: 'Animation', description: "This is for drawn shows." )
      video1 = Video.create(title: 'Vid 1', description: "This is a show about a family.", category: category)
      video2 = Video.create(title: 'Vid 2', description: "This is a show about a family.", category: category)
      video3 = Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category)
      video4 = Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category)
      video5 = Video.create(title: 'Vid 4', description: "This is a show about a family.", category: category)
      video6 = Video.create(title: 'Vid 41', description: "This is a show about a family.", category: category)
      video7 = Video.create(title: 'Vid 412', description: "This is a show about a family.", category: category)
      video8 = Video.create(title: 'Vid 4122', description: "This is a show about a family.", category: category)
      video9 = Video.create(title: 'Vid 41223', description: "This is a show about a family.", category: category)
      expect(category.display_most_recent_videos.count).to eq(6)
    end
    it 'returns an array ordered by created_at' do
      category = Category.create(title: 'Animation', description: "This is for drawn shows." )
      video1 = Video.create(title: 'Vid 1', description: "This is a show about a family.", category: category, created_at: 9.minutes.ago)
      video2 = Video.create(title: 'Vid 2', description: "This is a show about a family.", category: category, created_at: 8.minutes.ago)
      video3 = Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category, created_at: 7.minutes.ago)
      video4 = Video.create(title: 'Vid 3', description: "This is a show about a family.", category: category, created_at: 6.minutes.ago)
      video5 = Video.create(title: 'Vid 4', description: "This is a show about a family.", category: category, created_at: 5.minutes.ago)
      video6 = Video.create(title: 'Vid 41', description: "This is a show about a family.", category: category, created_at: 4.minutes.ago)
      video7 = Video.create(title: 'Vid 412', description: "This is a show about a family.", category: category, created_at: 3.minutes.ago)
      video8 = Video.create(title: 'Vid 4122', description: "This is a show about a family.", category: category, created_at: 2.minutes.ago)
      video9 = Video.create(title: 'Vid 41223', description: "This is a show about a family.", category: category, created_at: 1.minutes.ago)
      expect(category.display_most_recent_videos).to eq([video9, video8, video7, video6, video5, video4])

    end
  end
end
