require 'spec_helper'
 
describe Video do
  it "saves itself" do
    video = Video.new(title: "Batman", description: "Gotham needs a hero.")
    video.save
    expect(Video.last).to eq(video)
    # 'should' is still available, but rspec core team suggest above. 'should ==' is called rspec matcher
    # Video.last.title.should == "Batman"
    # Video.last.title.should eq(video)
  end
end