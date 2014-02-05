require 'spec_helper'
require 'shoulda-matchers'


describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe '#search' do
    it 'should return search query in params'
    it 'should return true when there are results'
    it 'should return false when there are no results to display'
  end
end
