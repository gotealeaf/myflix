require 'spec_helper'

describe Video do 
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  it "returns true if title is present"
  it "returns false if title is absent"
end

