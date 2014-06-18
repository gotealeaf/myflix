require 'rails_helper'

describe Category do
  # it "saves itself" do 
  #   category = Category.new(name: "Hyper Action")
  #   category.save
  #   expect(Category.first).to eq(category)
  # end

  it { should have_many (:videos) }
  # it "has many videos" do
  #   hyper_action = Category.create(name: "Hyper Action")
  #   walking_dead = Video.create(title: "The Walking Dead", description: "Scary, becoming-lame show.", category: hyper_action)
  #   flash_forward = Video.create(title: "Flash Forward", description: "A one season wonder.", category: hyper_action)
  #   expect(hyper_action.videos).to eq([flash_forward, walking_dead])
  # end

  describe '#recent_videos' do
    it 'returns the videos in reverse chronological order by created_at' do
      comedy = Category.create(name: 'Comedy')
      titanic = Video.create(title: 'Titanic', description: 'Share that raft, Rose!', category: comedy, created_at: 1.day.ago)
      forrest_gump = Video.create(title: 'Forrest Gump', description: 'Who doesn\'t love a box of chocolates?', category: comedy)
      expect(comedy.recent_videos).to eq([forrest_gump, titanic])
    end

    it 'returns all videos if there are less than 6' do
      comedy = Category.create(name: 'Comedy')
      titanic = Video.create(title: 'Titanic', description: 'Share that raft, Rose!', category: comedy, created_at: 1.day.ago)
      forrest_gump = Video.create(title: 'Forrest Gump', description: 'Who doesn\'t love a box of chocolates?', category: comedy)
      expect(comedy.recent_videos.count).to eq(2)
    end

    it 'returns only 6 videos if there are more than 6' do
      comedy = Category.create(name: 'Comedy')
      7.times { Video.create(title: 'Foo', description: 'Bar', category: comedy) }
      expect(comedy.recent_videos.count).to eq(6)
    end

    it 'returns the most recent 6 videos' do
      comedy = Category.create(name: 'Comedy')
      6.times { Video.create(title: 'Foo', description: 'Bar', category: comedy) }
      newest_vid = Video.create(title: "I'm so new!", description: "...and boring", category: comedy, created_at: 1.day.ago)
      expect(comedy.recent_videos).not_to include(newest_vid)
    end

    it 'returns an empty array if the category doesn\'t have any videos' do
      comedy = Category.create(name: 'Comedy')
      expect(comedy.recent_videos).to eq([])
    end
  end
end


