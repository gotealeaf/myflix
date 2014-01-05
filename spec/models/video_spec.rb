require 'spec_helper'

describe Video do
  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  describe "search_by_title" do
    it "returns empty array if no videos found" do
      Video.delete_all
      Video.search_by_title("Wizard").should == []
    end
    it "returns array with one element if one video found" do
      Video.delete_all
      video1 = Video.create(title: "The Wizard of Oz", description: "great video")
      video2 = Video.create(title: "Citizen Kane", description: "mediocre video")
      Video.search_by_title("The Wizard of Oz").should == [video1]
    end

    it "returns array of one video for a partial match" do
      Video.delete_all
      video1 = Video.create(title: "The Wizard of Oz", description: "great video")
      video2 = Video.create(title: "Citizen Kane", description: "mediocre video")
      Video.search_by_title("Wizard").should == [video1]
    end

    it "returns array with multiple elements if more than one video found ordered by created_at" do
      Video.delete_all
      video1 = Video.create(title: "The Wizard of Oz", description: "great video", created_at: 1.day.ago)
      video2 = Video.create(title: "The Wizards of Waverly Place", description: "horrible video")
      Video.search_by_title("Wiz").should == [video2, video1]
    end

    it "returns an empty array for a search with an empty string" do
      Video.delete_all
      video1 = Video.create(title: "The Wizard of Oz", description: "great video", created_at: 1.day.ago)
      video2 = Video.create(title: "The Wizards of Waverly Place", description: "horrible video")
      Video.search_by_title("").should == []
    end
  end
  
  # Since Rails takes care of making sure that records are saved properly, it's not necessary to test for this condition.
  #   it "saves itself" do
  #   category = Category.create(name: "Biographies")
  #   video = Video.new(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
  #   video.save
  #   expect(Video.first).to eq(video)
  #   # alternatives:
  #   #    Video.first.should == video
  #   #    Video.first.should eq(video)
  #   #    Video.first.title.should == "Capote" 
  # end
  # Since I'm using the shoulda gem, all of the following tests are duplicates
  # it "belongs to category" do
  #   biographies = Category.create(name: "Biographies")
  #   capote = Video.create(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: biographies)
  #   expect(capote.category).to eq(biographies)
  # alternative:
  # it "can have a category" do
  #   category = Category.create(name: "Biographies")
  #   video = Video.new(title: "Capote", description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
  #   video.save
  #   Video.first.category.should == category
  # end
  # it "will reject record without a title" do
     # category = Category.create(name: "Biographies")
     # video = Video.create(description: "The toast of New York City ...", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
     # expect(Video.count).to eq(0)
     # alternative:
     # Video.first.should == nil
  # end
  # it "will reject record without a description" do
    # category = Category.create(name: "Biographies")
    # video = Video.create(title: "Capote", small_cover_url: 'tmp/capote.jpg', large_cover_url: 'tmp/capote_large.jpg', category: category)
    # expect(Video.count).to eq(0)
    # alternative: 
    # Video.first.should == nil
  # end
end