require 'spec_helper'

describe Video do
  
  it {should belong_to(:category)}
  it {should have_many(:reviews).order("created_at desc")}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  
  describe "search_by_title" do
    it "returns an empty array if there are is no match" do
      video = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.')
      expect(Video.search_by_title('Monk')).to eq([])
    end
    
    it "returns an array of a single item if there is an exact match on one record" do
      video = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.')
      expect(Video.search_by_title('The Family Guy')).to eq([video])
      
    end
 
    it "returns an array of a single item if there is an partial match on one record" do
      video = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.')
      expect(Video.search_by_title('Family')).to eq([video])
    end

    it "returns an array of a multiple items ordered by created_at if there is a match on multiple records" do
      video = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.', created_at: 1.day.ago)
      video2 = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.')
      expect(Video.search_by_title('Family')).to eq([video2, video])
    end

    it "returns an empty array if the search term is blank" do
      video = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.', created_at: 1.day.ago)
      video2 = Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.')
      expect(Video.search_by_title('')).to eq([])
    end
  end
  
  describe "averge_rating" do
    
    it "returns the average review rating rounded to one decimal place if there is more then one review" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, rating: 2)
      review2 = Fabricate(:review, video: video, rating: 4)
      review3 = Fabricate(:review, video: video, rating: 5)
      expect(video.average_rating).to eq('3.7')
    end
    
    it "returns the reviews rating if there is only one review" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, rating: 2)
      expect(video.average_rating).to eq('2.0')
    end
    
    it "returns and empty string if there are no reviews" do
      video = Fabricate(:video)
      expect(video.average_rating).to eq('')
    end
  end
end
  