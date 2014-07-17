require 'rails_helper'

describe Genre do
  it { should have_many(:videos).order(:name) }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name}

  describe "#recent_videos" do
    it "returns an empty array if there are no videos in the genre" do
      expect(genre.recent_videos).to eq([])
    end
    it "returns an array with all video obj if there are < 6 in the genre" do
      video_1 = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      video_2 = Video.create(name: 'fight club', description: 'fighting movie', genre: genre)
      expect(genre.recent_videos).to include(video_1, video_2)
    end
    it "returns an array of 6 video obj when >= 6 in genre" do
      video_1 = Video.create(name: 'terminator', description: 'robots and armegaddon', genre: genre)
      video_2 = Video.create(name: 'terminator 2', description: 'more robots and armegaddon', genre: genre)
      video_3 = Video.create(name: 'fight club', description: 'fighting movie', genre: genre)
      video_4 = Video.create(name: 'top gun', description: 'jet fighters', genre: genre)
      video_5 = Video.create(name: 'die hard', description: 'cop and robbers', genre: genre)
      video_6 = Video.create(name: 'die harder', description: 'more cops and robbers', genre: genre)
      video_7 = Video.create(name: 'rambo', description: 'war movie', genre: genre)
      expect(genre.recent_videos.size).to eq(6)
    end
    it "returns an array of 6 videos obj in ascending order by created_at" do
      video_1 = Video.create(name: 'terminator', description: 'robots and armegaddon', created_at: '2014-06-14', genre: genre)
      video_2 = Video.create(name: 'terminator 2', description: 'more robots and armegaddon', created_at: '2014-06-15', genre: genre)
      video_3 = Video.create(name: 'fight club', description: 'fighting movie', created_at: '2014-06-16', genre: genre)
      video_4 = Video.create(name: 'top gun', description: 'jet fighters', created_at: '2014-06-17', genre: genre)
      video_5 = Video.create(name: 'die hard', description: 'cop and robbers', created_at: '2014-06-18', genre: genre)
      video_6 = Video.create(name: 'die harder', description: 'more cops and robbers', created_at: '2014-06-19', genre: genre)
      video_7 = Video.create(name: 'rambo', description: 'war movie', genre: genre)
      expect(genre.recent_videos).to eq([video_7,video_6,video_5,video_4,video_3,video_2])
    end
  end
end
