require 'spec_helper'

describe Category do
  it { have_many(:videos) }
end