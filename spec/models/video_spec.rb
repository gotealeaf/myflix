require 'rails_helper'

describe Video do
  
  it "should persist a video to the data store" do
    video = Video.new(title:'Aliens',
                      description:'Best sci-fi movie ever!',
                      small_cover_url:'http://placehold.it/166x236',
                      large_cover_url:'http://placehold.it/665x375')
    video.save
    expect(Video.first).to eq(video)
  end
  
  it "belongs to a category" do
    sci_fi = Category.create(name:'Sci-Fi')
    alien = Video.new(title:'Alien',
                      description: 'Second best sci-fi movie ever.',
                      category: sci_fi)
    alien.save
    expect(alien.category).to eq(sci_fi)
  end
  
  it "should require a title" do
    aliens = Video.create(description: 'Nuke it from orbit!')
    expect(aliens).to_not be_valid
  end
  
  it "should require a description" do
    aliens = Video.new(title: 'Aliens')
    expect(aliens).to_not be_valid
  end
  
end