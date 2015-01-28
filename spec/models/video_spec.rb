require 'rails_helper'

describe Video do 
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:categories).through(:video_categories) }
  it { should have_many(:reviews).order('created_at desc')}
  it { should have_many(:my_queue_videos)}

  it 'should return blank when search keyword is empty' do
    et = Video.create(title: 'et', description: 'lalalala')
    expect(Video.search('')).to eq([])
  end

  it 'should return a list of videos when exact match are found' do
    et = Video.create(title: 'et', description: 'lalalala')
    expect(Video.search('et')).to eq([et])
  end
  it 'should return a list of videos  when partial match are found' do
    et = Video.create(title: 'et', description: 'lalalala', created_at: 1.day.ago)
    ettt = Video.create(title: 'ettt', description: 'lalalala')
    expect(Video.search('e')).to eq([ettt, et])
  end
  it 'should return empty list when no match are found' do   
    et = Video.create(title: 'et', description: 'lalalala')
    expect(Video.search('lala')).to eq([])
  end
end


  