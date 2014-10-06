require 'spec_helper'

describe Video do 
  it 'should_save' do
    Video.all.each do |v|
      v.delete
    end

    video = Video.create    
    Video.first.should == video  
  end  
end