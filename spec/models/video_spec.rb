require 'rails_helper'

describe Video do
  it { should have_many(:reviews).order(created_at: :desc) }
  it { should belong_to(:genre) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:genre_id) }
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of :name }

  describe '#search_by_name' do

    let(:genre) { Fabricate(:genre) }

    it 'should return an empty array if no videos are found' do
      expect(Video.search_by_name('terminator')).to eq([])
    end
    it 'should return and array of one video object if there is one in the database' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      expect(Video.search_by_name('terminator')).to eq([video])
    end
    it 'should return an array of one video for a case insensitive match' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      expect(Video.search_by_name('Terminator')).to eq([video])
    end
    it 'should return an array of one video object for a partial match' do
      video = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      expect(Video.search_by_name('term')).to eq([video])
    end
    it 'should return an array of video objects if there are multiple matches' do
      video_1 = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      video_2 = Video.create(name: 'terminator 2', description: 'more robots and armegaddon', genre: genre)
      expect(Video.search_by_name('term')).to match_array([video_1, video_2])
    end
  end
end
