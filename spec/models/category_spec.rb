require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  it 'saves itself' do
    tv = Category.new(name: 'TV')
    tv.save
    expect(Category.first).to eq(tv)
  end
  
  describe 'recent_videos' do
    it 'returns videos in reverse chronical order by created at' do
      drama = Category.create(name: 'Drama')
      annie_hall = Video.create(title: 'Annie Hall', description: 'n/a', category: drama, created_at: 1.day.ago) 
      seven = Video.create(title: 'Seven', description: 'n/a', category: drama)
      expect(drama.recent_videos).to eq([seven, annie_hall])
    end

    it 'returns all videos if there are less than 6 videos' do
      drama = Category.create(name: 'Drama')
      annie_hall = Video.create(title: 'Annie Hall', description: 'n/a', category: drama, created_at: 1.day.ago) 
      seven = Video.create(title: 'Seven', description: 'n/a', category: drama)
      expect(drama.recent_videos.size).to eq(2) 
    end

    it 'returns 6 videos if there are more than 6 videos' do
      drama = Category.create(name: 'Drama')
      7.times { Video.create(title: 'Seven', description: 'n/a', category: drama) }
      expect(drama.recent_videos.size).to eq(6) 
    end

    it 'returns most recent 6 videos' do
      drama = Category.create(name: 'Drama')
      7.times { Video.create(title: 'Seven', description: 'n/a', category: drama) }
      annie_hall = Video.create(title: 'Annie Hall', description: 'n/a', category: drama, created_at: 1.day.ago) 
      expect(drama.recent_videos).not_to include(annie_hall)
    end
  end

end
