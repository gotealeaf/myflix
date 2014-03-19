require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end