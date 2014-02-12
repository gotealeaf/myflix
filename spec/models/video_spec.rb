require 'spec_helper'
require 'shoulda-matchers'


describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'search_by_title' do
    it 'returns an empty array if there is no match' do
      simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
      futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      expect(Video.search_by_title('Great happy place')).to eq([])
    end
    it 'returns an array of one video if there is an exact match' do
      simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
      futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      expect(Video.search_by_title('simpsons')).to eq([simpsons])
    end
    it 'returns an array of multiple videos if it is a partial match' do
      simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
      futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      expect(Video.search_by_title('!')).to eq([futurama, simpsons])
    end
    it 'returns an array of all matches ordered by created_at (most recent first)' do
      simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.', created_at: 1.days.ago)
      futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      expect(Video.search_by_title("!")).to eq([futurama, simpsons])
    end
  end
end
