require 'rails_helper.rb'

describe Category do
  it { should have_many(:videos)}
end
