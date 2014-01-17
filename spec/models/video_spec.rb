require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of(:title) }
  it { should have_many(:reviews).order('created_at desc') }

  it 'saves itself' do
    monk = Video.new(title: 'monk', description: 'n/a')
    monk.save
    expect(Video.first).to eq(monk)
  end
end

describe 'search_by_title' do
  it 'returns an empty array for a search of empty string' do
    futurama = Video.create(title: 'Futurama', description: 'n/a')
    expect(Video.search_by_title('')).to eq([])
  end

  it 'returns an empty array if there is no match' do
    futurama = Video.create(title: 'Futurama', description: 'n/a')
    expect(Video.search_by_title('test')).to eq([])
  end

  it 'returns an array of one video for an exact match' do
    futurama = Video.create(title: 'Futurama', description: 'n/a')
    expect(Video.search_by_title('futurama')).to eq([futurama])
  end

  it 'returns an array of all matches for a partial match and ordered by created_at' do
    futurama = Video.create(title: 'Futurama', description: 'n/a')
    back_to_future = Video.create(title: 'Back To Future', description: 'n/a')
    expect(Video.search_by_title('futu')).to eq([back_to_future, futurama])
  end

end

describe 'average_rating' do
  let(:video) { Fabricate(:video) }
  context 'video has no rating' do
    it 'sets average rating to 0' do
      expect(video.average_rating).to eq(0)
    end
  end
  context 'video has ratings' do
    it 'sets average rating as rounded float' do
      review1 = Fabricate(:review, rating: 2, video_id: video.id)
      review2 = Fabricate(:review, rating: 3, video_id: video.id)
      expect(video.average_rating).to eq(2.5)
    end
  end
end
