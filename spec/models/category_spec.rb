require "spec_helper"

describe Category do

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  describe "#recent_videos" do

<<<<<<< HEAD
    let(:cat){ Fabricate(:category) }
    let(:subject) { cat.recent_videos.count }

    context "less than 6"do
      before do
        5.times { Fabricate(:video, category_id: cat.id) }
      end
      it { should == 5 }
    end
    context "only 6" do
      before do
        6.times { Fabricate(:video, category_id: cat.id) }
      end
      it { should == 6 }
    end

    context "more than 6" do
      before do
        10.times { Fabricate(:video, category_id: cat.id) }
      end
      it { should == 6 }
    end

    context "return order" do
      let(:subject) { cat.recent_videos.first.title}
      before do
        10.times { Fabricate(:video, category_id: cat.id, created_at: 1000.days.ago) }
        first = Fabricate(:video, title: "lastest",category_id: cat.id)
      end
      it{ should == "lastest" }
=======
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
>>>>>>> fb59e9e41e3518be60b91532c366501824f17f62
    end
  end
end
