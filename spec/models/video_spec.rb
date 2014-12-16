require 'rails_helper'

describe Video do 
  it 'should_save' do    
     # Video.all.each do |v|
     #   v.delete
     # end
    video = Video.create(title: 'et', description: 'sifimovie')   
    # Video.first.should == video  
    expect(Video.first).to eq(video)
  end  

  it 'should not save without a title' do
    video = Video.create(description: 'test123')
    expect(Video.count).to eq(0)
  end
  it 'should not save without a description' do
    video = Video.create(title: 'test123')
    expect(Video.count).to eq(0)
  end
end


