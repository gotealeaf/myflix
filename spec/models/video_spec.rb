require 'rails_helper'

describe Video do
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should belong_to(:genre) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of :name }

  describe '#search_by_name' do
    it 'should return an empty array if no videos are found' do
      expect(Video.search_by_name('terminator')).to eq([])
    end
    it 'should return and array of one video object if there is one in the database' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon')
      expect(Video.search_by_name('terminator')).to eq([video])
    end
    it 'should return an array of one video for a case insensitive match' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon')
      expect(Video.search_by_name('Terminator')).to eq([video])
    end
    it 'should return an array of one video object for a partial match' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon')
      expect(Video.search_by_name('term')).to eq([video])
    end
    it 'should return an array of video objects if there are multiple matches' do
      video_1 = Video.create(name: 'terminator', description: 'robots and armegaddon')
      video_2 = Video.create(name: 'terminator 2', description: 'more robots and armegaddon')
      expect(Video.search_by_name('term')).to match_array([video_1, video_2])
    end
  end

  context '#avg_rating' do
    it "returns 'no ratings available' when there are no ratings" do
      expect(video.avg_rating).to eq('no ratings available')
    end
    it "returns the average rating for the selected video" do
      review_1 = Fabricate(:review, user: user, video: video)
      review_2 = Fabricate(:review, user: user, video: video)
      average = Review.where(video: video).average(:rating).to_s
      expect(video.avg_rating).to eq(average)
    end
  end
end
