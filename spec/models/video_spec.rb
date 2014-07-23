require "spec_helper"

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:large_cover_image_url) }
  it { should validate_presence_of(:small_cover_image_url) }
  it { should validate_presence_of(:category_id) }


  describe "search" do
    let(:test1) { Fabricate(:video, created_at: 100.days.ago) }
    let(:test2) { Fabricate(:video, title: "monkket") }

    it "should return empty array if no match" do
      expect(Video.search("I dont Know")).to eq([])
    end

    it "should return a array of a obj if a perfect match" do
      expect(Video.search("Monk")).to eq([test1])
    end

    it "should return a array of a obj if a partial match" do
      expect(Video.search("Adrian Monk")).to eq([test1])
    end

    it "should return a array of objs in order of created_at" do
      expect(Video.search("Monk")).to eq([test2, test1])
    end
    it "should return empty array if input is empty str" do
      expect(Video.search("")).to eq([])
    end
  end
end
