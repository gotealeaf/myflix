require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe '::search_by_title' do
    it 'allows case-insensitive searches' do
      sons_of_anarchy = Video.create(title: 'Sons of Anarchy - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('anarchy')).to eq([sons_of_anarchy])
    end

    it 'returns an empty array if no videos match' do
      Video.create(title: 'Sons of Anarchy - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('Sesame Street')).to eq([])
    end

    it 'returns an array with one item if one video matches exactly' do
      sons_of_anarchy = Video.create(title: 'Sons of Anarchy - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('Sons of Anarchy - Pilot')).to eq([sons_of_anarchy])
    end

    it 'returns an array with one item if one video partially matches' do
      sons_of_anarchy = Video.create(title: 'Sons of Anarchy - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('Anarchy')).to eq([sons_of_anarchy])
    end

    it 'returns an array of all matching videos ordered by created_at' do
      sons_of_anarchy_1 = Video.create(title: 'Sons of Anarchy - Pilot',
                                       description: 'The pilot.', created_at: 2.days.ago)
      sons_of_anarchy_2 = Video.create(title: 'Sons of Anarchy - Ep 2',
                                       description: 'The second episode.', created_at: 1.day.ago)
      sons_of_anarchy_3 = Video.create(title: 'Sons of Anarchy - Ep 3', description: 'The third episode.')
      Video.create(title: 'House, M.D. - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('Anarchy')).to eq([sons_of_anarchy_3, sons_of_anarchy_2, sons_of_anarchy_1])
    end

    it 'returns an empty array if search string is empty' do
      Video.create(title: 'House, M.D. - Pilot', description: 'The pilot.')
      expect(Video.search_by_title('')).to eq([])
    end
  end

  describe '#average_rating' do
    it 'returns a float with a maximum of three decimals' do
      video = Fabricate(:video)
      [3, 1, 4].each { |rating| Fabricate(:review, rating: rating, video: video) }
      expect(video.average_rating).to eq(2.667)
    end
  end
end
