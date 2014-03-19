require 'spec_helper'

describe Video do
  it { should have_many(:categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "::search_by_title" do
    it 'returns an empty array if no objects are found' do
      Video.create(title: "Breaking Bad", description: "Chemistry")
      Video.create(title: "Back to the Future", description: "Science")
      expect(Video.search_by_title("testing")).to eq([])
    end

    it 'returns an array with one object if only one object is found' do
      zoo = Video.create(title: "Zoolander", description: "Male models")
      sj = Video.create(title: "Space Jam", description: "Best. Movie. Ever. No male models though.")
      expect(Video.search_by_title("Zoolander")).to eq([zoo])
    end
    
    it 'returns an array with many objects if many objects are found' do
      sandlot1 = Video.create(title: "Sandlot", description: "Wendy Peffercorn!")
      sandlot2 = Video.create(title: "Sandlot 2", description: "Bleh")
      expect(Video.search_by_title("Sandlot").size).to eq(2)
    end
    
    it 'can handle a partial match' do
      acs = Video.create(title: "A Christmas Story", description: "Merry Christmas.")
      expect(Video.search_by_title("istm")).to eq([acs])
    end
    
    it "can handle incorrect case" do
      borat = Video.create(title: "Borat", description: "Kazakhstan")
      expect(Video.search_by_title("boRaT")).to eq([borat])
    end

    it "returns arrays sorted by the created time" do 
      video1 = Video.create(title: "Video", description: "Description 1")
      video2 = Video.create(title: "Video", description: "Description 2", created_at: 1.day.ago)
      video3 = Video.create(title: "Video", description: "Description 3")
      expect(Video.search_by_title("Video")).to eq([video3, video1, video2])
    end

    it "returns an empty array if search string is empty" do
      video1 = Video.create(title: "Video", description: "Description 1")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end