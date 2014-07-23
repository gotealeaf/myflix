require "spec_helper"

describe Category do

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  describe "#recent_videos" do

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
    end
  end
end
