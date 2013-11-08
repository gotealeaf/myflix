require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'search_by_title' do
    it 'returns empty array if no videos match' do
      family_guy = Video.create(title: 'Family Guy')
      breaking_bad = Video.create(title: 'Breaking Bad')
      expect(Video.search_by_title('monk')).to eq([])
    end

    it 'returns an array of one video for an exact match' do
      family_guy = Video.create(title: 'Family Guy')
      breaking_bad = Video.create(title: 'Breaking Bad')
      expect(Video.search_by_title('Family')).to eq([family_guy])
    end

    it 'returns an array of all matches ordered by title' do 
    end
  end
end