require "spec_helper"

describe Category do

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  describe "#recent_videos" do

    let(:cat){ Category.create(name: "testing") }

    it "return in created_at desc order" do
      test1 = Video.create(title: "test", description: "##testing_case", large_cover_image_url: "url_str", small_cover_image_url: "url_str", category: cat, created_at: 50.days.ago)
      test2 = Video.create(title: "test", description: "##testing_case", large_cover_image_url: "url_str", small_cover_image_url: "url_str", category: cat)
      expect(cat.recent_videos).to eq([test2, test1])
    end

    it "get all videos when there is less than 6 videos" do
      5.times { Video.create(title: "test", description: "##testing_case", large_cover_image_url: "url_str", small_cover_image_url: "url_str", category: cat) }

      expect(cat.recent_videos.count).to eq(5)
    end
    it "return 6 videos when there are only 6" do
      6.times { Video.create(title: "test", description: "##testing_case", large_cover_image_url: "url_str", small_cover_image_url: "url_str", category: cat) }
      expect(cat.recent_videos.count).to eq(6)
    end

    it "return most recent 6 videos " do

      10.times { Video.create(title: "test", description: "##testing_case", large_cover_image_url: "url_str", small_cover_image_url: "url_str", category: cat) }

      expect(cat.recent_videos.count).to eq(6)
    end
  end
end
