require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe '#recent_videos' do
    it 'return an empty array if there are no videos in that category' do
      drama = Category.create(name: "Drama")
      expect(drama.recent_videos).to eq([])
    end

    it 'return videos in reverse chronical order by created_at' do
      drama = Category.create(name: 'Drama')
      illusionist = Video.create(title: "The Illusionist", description: "magician",created_at: 1.day.ago, category: drama)
      gump = Video.create(title: "Forrest Gump", description: "Forrest Gump", category: drama)
      expect(drama.recent_videos).to eq([gump, illusionist]) 
    end

    it 'return an array of all the videos if there are less than 6 videos for that category' do
      drama = Category.create(name: 'Drama')
      illusionist = Video.create(title: "The Illusionist", description: "magician",created_at: 1.day.ago, category: drama)
      gump = Video.create(title: "Forrest Gump", description: "Forrest Gump", category: drama)
      expect(drama.recent_videos.count).to eq([gump, illusionist].size) 
    end
    it 'return an array of 6 videos if there are more than 6 videos in that category' do
      drama = Category.create(name: 'Drama')
      7.times { Video.create(title: "The Illusionist", description: "magician",category: drama) }
      expect(drama.recent_videos.count).to eq(6) 
    end

    it 'return the most recent 6 videos' do
      drama = Category.create(name: 'Drama')
      6.times { |t| Video.create(title: "The Illusionist", description: "magician", category: drama)}
      illusionist = Video.create(title: "The Illusionist", description: "magician", created_at: 1.day.ago, category: drama)
      expect(drama.recent_videos).not_to include(illusionist)
    end
  end
end


 