require "spec_helper"

describe Video do 
  it { should have_many(:categories).through(:video_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do

    end    
    it "returns an array of one video for an exact match" do
      
    end
    it "returns an array of one video for a partial match" do
      
    end
    it "returns an array of all matched ordered by created_at" do
      
    end
  end
end