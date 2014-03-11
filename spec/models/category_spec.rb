require 'spec_helper'

describe Category do 
  it { should have_many(:video_categories) }
  it { should have_many(:videos).through(:video_categories) }
end