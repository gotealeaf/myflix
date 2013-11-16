require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order('created_ad DESC') }

  describe '.search_by_title' do
    before :each do
      @family_guy = Fabricate(:video, title: 'Family Guy', created_at: 1.day.ago)
      @breaking_bad = Fabricate(:video, title: 'Breaking Bad')
    end

    it 'returns empty array if no videos match' do
      expect(Video.search_by_title('monk')).to eq([])
    end

    it 'returns an array of one video for an exact match' do
      expect(Video.search_by_title('Family')).to eq([@family_guy])
    end

    it 'returns an array of one video for a partial match' do
      expect(Video.search_by_title('reak')).to eq([@breaking_bad])
    end

    it 'returns an array of all matches ordered by created_at DESC' do 
      expect(Video.search_by_title('a')).to eq([@breaking_bad, @family_guy])
    end

    it 'returns an empty array for a search with an empty string' do
      expect(Video.search_by_title('')).to eq([])
    end
  end
end