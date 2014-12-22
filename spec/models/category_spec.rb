require 'rails_helper'

describe Category do

  # it 'should have many videos' do
  #   sifi = Category.create(name: 'Sicence Fiction')
  #   intelerstar = Video.create(title: 'intelerstar', description: 'interesting', categories: [sifi])
  #   et = Video.create(title: 'endt', description: 'not interesting', categories: [sifi])
  #   expect(sifi.videos).to eq([et, intelerstar])
  # end
  
  it { should have_many(:videos).through(:video_categories).order('title') }

  # test recent_videos instance method
  describe "#recent_videos" do
    it 'should return the most 6 recent videos on reverse order' do
      category = Category.create(name: 'test')
      v1 = Video.create(title: 'v1', description: 'blablabla', created_at: 6.day.ago, categories: [category] )
      v2 = Video.create(title: 'v2', description: 'blablabla', created_at: 5.day.ago, categories: [category] )
      v3 = Video.create(title: 'v3', description: 'blablabla', created_at: 4.day.ago, categories: [category] )
      v4 = Video.create(title: 'v4', description: 'blablabla', created_at: 3.day.ago, categories: [category] )
      v5 = Video.create(title: 'v5', description: 'blablabla', created_at: 2.day.ago, categories: [category] )
      v6 = Video.create(title: 'v6', description: 'blablabla', created_at: 1.day.ago, categories: [category] )
      v7 = Video.create(title: 'v7', description: 'blablabla', created_at: 0.day.ago, categories: [category] )
      expect(category.recent_videos).to eq([v7, v6, v5, v4, v3, v2])     
    end   

    it 'should return all the videos on reverse order if total video less than 6' do
      category = Category.create(name: 'test')
      v1 = Video.create(title: 'v1', description: 'blablabla', created_at: 1.day.ago, categories: [category] )
      v2 = Video.create(title: 'v2', description: 'blablabla', created_at: 0.day.ago, categories: [category] )
      expect(category.recent_videos).to eq([v2, v1])
    end
  
  end
  
end