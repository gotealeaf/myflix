require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe '#recent_videos' do
    it 'returns all videos if less than six exist in this category' do
      drama = Category.create(name: 'drama')
      Video.create([{ title: 'Sons of Anarchy', description: 'A silly mouse.', category: drama },
                    { title: 'Dexter', description: 'A vigilante serial killer', category: drama },
                    { title: 'Breaking Bad', description: "Walter White 'kills' it", category: drama }])
      expect(drama.recent_videos.count).to eq(3)
    end

    it 'returns all videos if exactly six exist in this category' do
      drama = Category.create(name: 'drama')
      Video.create([{ title: 'Sons of Anarchy', description: 'A silly mouse.', category: drama },
                    { title: 'Sons of Anarchy 2', description: 'A silly mouse.', category: drama },
                    { title: 'Dexter', description: 'A vigilante serial killer', category: drama },
                    { title: 'Dexter 2', description: 'A vigilante serial killer', category: drama },
                    { title: 'Breaking Bad', description: "Walter White 'kills' it", category: drama },
                    { title: 'Breaking Bad 2', description: "Walter White 'kills' it", category: drama }])
      expect(drama.recent_videos.count).to eq(6)
    end

    it 'returns at most six videos if more than six exist' do
      drama = Category.create(name: 'drama')
      Video.create([{ title: 'Sons of Anarchy', description: 'A silly mouse.', category: drama },
                    { title: 'Sons of Anarchy 2', description: 'A silly mouse.', category: drama },
                    { title: 'Sons of Anarchy 3', description: 'A silly mouse.', category: drama },
                    { title: 'Dexter', description: 'A vigilante serial killer', category: drama },
                    { title: 'Dexter 2', description: 'A vigilante serial killer', category: drama },
                    { title: 'Dexter 3', description: 'A vigilante serial killer', category: drama },
                    { title: 'Breaking Bad', description: "Walter White 'kills' it", category: drama },
                    { title: 'Breaking Bad 2', description: "Walter White 'kills' it", category: drama },
                    { title: 'Breaking Bad 3', description: "Walter White 'kills' it", category: drama }])
      expect(drama.recent_videos.count).to eq(6)
    end

    it 'returns videos in descending order, based on created_at' do
      drama = Category.create(name: 'drama')
      sons_of_anarchy = Video.create(title: 'Sons of Anarchy', description: 'A silly mouse.', category: drama, created_at: 2.days.ago)
      dexter = Video.create(title: 'Dexter', description: 'A vigilante serial killer', category: drama, created_at: 1.days.ago)
      breaking_bad = Video.create(title: 'Breaking Bad', description: "Walter White 'kills' it", category: drama)
      expect(drama.recent_videos).to eq([breaking_bad, dexter, sons_of_anarchy])
    end

    it 'returns an empty array if the category has no videos' do
      drama = Category.create(name: 'drama')
      expect(drama.recent_videos).to eq ([])
    end
  end
end
