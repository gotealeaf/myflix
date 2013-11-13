require 'spec_helper'

describe Category do
  it 'saves itself' do 
    category = Category.new(name: 'New test')
    category.save
    expect(Category.find category).to eq(category)
  end
  it 'has many videos' do
    crime_scene = Category.create(name: 'Crime Scene')
    test_video1 = Video.create(title: 'video1', description: 'desc1', category: crime_scene)
    test_video2 = Video.create(title: 'video2', description: 'desc2', category: crime_scene)
    expect(crime_scene.videos).to include(test_video1, test_video2)
    expect(crime_scene.videos).to eq([test_video1, test_video2])

    should have_many(:videos)
  end
  it 'is valid with name' do 
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end
end