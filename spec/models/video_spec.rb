require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  
  it "returns an empty array if no results found" do
    Video.create(name: "epic", description: "Also epic")
    Video.search_by_name("chump").should == []
  end
  
  it "returns an array when you search for an item" do
    Video.create(name: "epic", description: "Also epic")
    Video.create(name: "double", description: "Also epic")
    Video.create(name: "epic", description: "Also epic")
    Video.search_by_name("epic").length.should == 2
  end
end