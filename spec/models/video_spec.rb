require 'spec_helper'

describe Video do
  
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC")}
  it { should have_many(:queue_items) }


  describe "in my queue" do

    it "finds video in my queue when in my queue" do
      rick = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video:video, user:rick)
      expect(video.in_my_queue?(rick)).to eq(true)
    end

    it "knows video is NOT in my queue when its not" do
      rick = Fabricate(:user)
      video = Fabricate(:video)
      expect(video.in_my_queue?(rick)).to eq(false)
    end



  end



  describe "find recent videos do" do

    it "searches and finds no videos when none exist" do
      found_videos = Video.recent_videos
      expect(found_videos.count).to eq(0)
    end 

    it "searches and finds six videos in order when a lot of videos" do
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")
      rage = Video.create(title: "Raging Bull", description: "Boxing movie")
      squirrel = Video.create(title: "Rocky", description: "not Rambo")
      hocky = Video.create(title: "Hocky", description: "not Rambo")
      docky = Video.create(title: "Docky", description: "not Rambo")
      socky = Video.create(title: "Socky", description: "not Rambo")
      locky = Video.create(title: "rLcky", description: "not Rambo")

      found_videos = Video.recent_videos
      expect(found_videos).to eq([locky,socky,docky,hocky, squirrel,rage])

    end 
  end


  describe "search_by_title" do 

    it "searches and finds no videos when none match" do
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")
      found_videos = Video.search_by_title("Periwinkle")
      expect(found_videos.count).to eq(0)
    end 

    it "searches and finds one video when one matches" do
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")
      found_videos = Video.search_by_title("Bull")
      expect(found_videos).to eq([moose])
    end 

    it "finds partial matches returned by created at" do
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")
      rage = Video.create(title: "Raging Bull", description: "Boxing movie")
      squirrel = Video.create(title: "Rocky", description: "not Rambo")
      found_videos = Video.search_by_title("Bull")
      expect(found_videos).to eq([moose, rage])
    end 

    it "searches and returns and empty array when the search term is empty" do
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")
      found_videos = Video.search_by_title("")
      expect(found_videos).to eq([])
    end

  end


end
