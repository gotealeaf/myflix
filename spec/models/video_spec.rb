require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'search_by_title' do
    before :each do
      @family_guy = Video.create(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', created_at: 1.day.ago)
      @breaking_bad = Video.create(title: 'Breaking Bad', description: "To provide for his family's future after he is diagnosed with lung cancer, a chemistry genius turned high school teacher teams up with an ex-student to cook and sell the world's purest crystal meth.")
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