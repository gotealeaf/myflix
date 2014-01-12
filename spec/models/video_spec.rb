require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      kungfu = Video.create(title: "Kung Fu", description: "Actor ZhouXingchi")
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda named Pao")
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for an exact match" do
      kungfu = Video.create(title: "Kung Fu", description: "Actor ZhouXingchi")
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda named Pao")
      expect(Video.search_by_title("Kung Fu Panda")).to eq([kungfu_panda])
    end
    it "returns an array of one video for a partial match" do
      kungfu = Video.create(title: "Kung Fu", description: "Actor ZhouXingchi")
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda named Pao")
      expect(Video.search_by_title("Pan")).to eq([kungfu_panda])
    end
    it "returns an array of all matches ordered by creaded_at" do
      kungfu = Video.create(title: "Kung Fu", description: "Actor ZhouXingchi", created_at: 1.day.ago)
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda named Pao")
      expect(Video.search_by_title("Kung")).to eq([kungfu_panda, kungfu])
    end
    it "returns an [] by search nil" do
      kungfu = Video.create(title: "Kung Fu", description: "Actor ZhouXingchi", created_at: 1.day.ago)
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda named Pao")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
