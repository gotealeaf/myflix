require "rails_helper"

RSpec.describe Category, :type => :model do

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  describe "#recent_videos" do
    it " return in created_at desc order" do

    end

    it " get all videos when there is less than 6 videos"

    it " return 6 videos when there are only 6"
    it " return most recent 6 videos " do

    end
  end
end
