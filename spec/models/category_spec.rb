require 'spec_helper'

describe Category do
  it {should have_many(:videos)}
  
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