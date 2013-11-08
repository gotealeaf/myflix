require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe '#recent_videos' do
    it 'returns videos in the most recent created_at order' do
      tv_drama = Category.create(name: "TV Drama")
      breaking_bad = Video.create(title: 'Breaking Bad', description: "To provide for his family's future after he is diagnosed with lung cancer, a chemistry genius turned high school teacher teams up with an ex-student to cook and sell the world's purest crystal meth.", category: tv_drama, created_at: 1.day.ago)
      walking_dead = Video.create(title: 'The Walking Dead', description: 'Police officer Rick Grimes leads a group of survivors in a world overrun by zombies.', category: tv_drama)
      expect(tv_drama.recent_videos).to eq([walking_dead, breaking_bad])
    end
    it 'returns all videos if there are <= 6' do
      tv_drama = Category.create(name: "TV Drama")
      breaking_bad = Video.create(title: 'Breaking Bad', description: "To provide for his family's future after he is diagnosed with lung cancer, a chemistry genius turned high school teacher teams up with an ex-student to cook and sell the world's purest crystal meth.", category: tv_drama, created_at: 1.day.ago)
      walking_dead = Video.create(title: 'The Walking Dead', description: 'Police officer Rick Grimes leads a group of survivors in a world overrun by zombies.', category: tv_drama)
      expect(tv_drama.recent_videos.count).to eq(2)
    end
    it 'returns only 6 videos if there are > 6' do
      tv_drama = Category.create(name: "TV Drama")
      counter = 1
      7.times.each do
        counter += 1
        Video.create(title: "foo #{counter}", description: 'bar', category: tv_drama)
      end
      expect(tv_drama.recent_videos.count).to eq(6)
    end
    it 'returns the most recent 6 videos' do
      tv_drama = Category.create(name: "TV Drama")
      counter = 1
      6.times.each do
        counter += 1
        Video.create(title: "foo #{counter}", description: 'bar', category: tv_drama)
      end
      greys_anatomy = Video.create(title: "Grey's Anatomy", description: 'Hospital', category: tv_drama, created_at: 1.day.ago)
      expect(tv_drama.recent_videos).not_to include(greys_anatomy)
    end
    it 'returns an empty array if category has no videos' do
      tv_drama = Category.create(name: "TV Drama")
      expect(tv_drama.recent_videos).to eq([])
    end
  end
end