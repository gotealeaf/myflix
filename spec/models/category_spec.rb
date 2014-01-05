require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

  describe "#recent_videos" do
    it "returns no videos" do
      Video.delete_all
      biographies = Category.create(name: "Biographies")
      expect(biographies.recent_videos.count).to eq(0)
    end
    it "finds less than six videos" do
      Video.delete_all
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies)
      expect(biographies.recent_videos.count).to eq(3)
    end
    it "finds more than six videos but returns only six videos" do
      Video.delete_all
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies)
      video4 = Video.create(title: "Fourth Video", description: "great video", category: biographies)
      video5 = Video.create(title: "Fifth Video", description: "great video", category: biographies)
      video6 = Video.create(title: "Sixth Video", description: "great video", category: biographies)
      video7 = Video.create(title: "Seventh Video", description: "great video", category: biographies)
      expect(biographies.recent_videos.count).to eq(6)
    end
    it "finds six videos in reverse chronicalogical correct order, sorted by created_at" do
      Video.delete_all
      biographies = Category.create(name: "Biographies")
      video1 = Video.create(title: "First Video", description: "great video", category: biographies, created_at: 1.day.ago)
      video2 = Video.create(title: "Second Video", description: "great video", category: biographies, created_at: 2.days.ago)
      video3 = Video.create(title: "Third Video", description: "great video", category: biographies, created_at: 3.days.ago)
      video4 = Video.create(title: "Fourth Video", description: "great video", category: biographies, created_at: 4.days.ago)
      video5 = Video.create(title: "Fifth Video", description: "great video", category: biographies, created_at: 7.days.ago)
      video6 = Video.create(title: "Sixth Video", description: "great video", category: biographies, created_at: 5.days.ago)
      video7 = Video.create(title: "Seventh Video", description: "great video", category: biographies, created_at: 6.days.ago)
      expect(biographies.recent_videos).to eq([video1, video2, video3, video4, video6, video7])
    end
  end
  
  # Since Rails takes care of making sure that records are saved properly, it's not necessary to test for this condition.
  # it "saves itself" do
  #   category = Category.new(name: "Biographies")
  #   category.save
  #   expect(Category.first).to eq(category)
  # end
  # Since I'm using the shoulda gem, all of the following tests are duplicates
  # it "can have zero videos" do
  #   category = Category.create(name: "Biographies")
  #   other_category = Category.create(name: "Political Dramas")
  #   video = Video.new(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: other_category)
  #   video.save
  #   category.videos.should == []
  # end
  # it "can have one video" do
  #   category = Category.create(name: "Biographies")
  #   video = Video.new(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
  #   video.save
  #   Category.first.videos.should == [video]
  # end
  # it "has many videos" do
  #   biographies = Category.create(name: "Biographies")
  #   capote = Video.create(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: biographies)
  #   all_that_jazz = Video.create(title: "All that Jazz", description: "Bob Fosse's Oscar-winning autobiographical film ...", small_cover_url: 'tmp/allthatjazz.jpg', large_cover_url: 'tmp/allthatjazz_large.jpg', category: biographies)
  #   expect(biographies.videos).to eq([all_that_jazz, capote])
  # end
  # alternative:
  # it "can have two videos" do
  #   category = Category.create(name: "Biographies")
  #   video = Video.new(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
  #   video.save
  #   video = Video.new(title: "All that Jazz", description: "Bob Fosse's Oscar-winning autobiographical film ...", small_cover_url: 'tmp/allthatjazz.jpg', large_cover_url: 'tmp/allthatjazz_large.jpg', category: category)
  #   video.save
  #   Category.first.videos.count.should == 2
  # end
end