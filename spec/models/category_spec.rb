require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe Category do

  it { should have_many(:videos) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

end
