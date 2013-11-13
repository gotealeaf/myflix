require 'spec_helper'

describe Video do
  it 'save itself' do
    video = Video.new(title: 'test', description: 'Good test movie')
    video.save
    expect(Video.find video).to eq(video)

    # should syntax is not suggested.
    # (Video.find video).should == video
    # (Video.find video).should eq(video)
  end
  it 'belongs to category' do
    crime_scene = Category.create(name: 'Crime Scene')
    test_video1 = Video.create(title: 'video1', description: 'desc1', category: crime_scene)
    expect(test_video1.category).to eq(crime_scene)

    should belong_to(:category)
  end
  it 'does not save video without title' do
    current_count = Video.count  
    video = Video.create(description: 'miss title')

    # if save failed, atrributes for model object will be nil.
    expect(video.id).to be_nil 
    expect(Video.count - current_count).to eq(0) 
  end

  it 'does not save video without description' do 
    current_count = Video.count 
    video = Video.create(title: 'miss description')
    expect(video.id).to be_nil
    expect(Video.count - current_count).to eq(0) 
  end

  it 'is valid with title' do
    # videos = Video.all
    # videos.each do |v|
    #   expect(v.title).to_not be_nil
    # end
    should validate_presence_of(:title)
  end
  it 'is valid with description' do
    should validate_presence_of(:description)
  end
end
