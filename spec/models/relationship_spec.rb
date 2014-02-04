require 'spec_helper'

describe Relationship do
  it { should belong_to :user }
  it { should belong_to :leader }
  it { should validate_presence_of :user }
  it { should validate_presence_of :leader }
end
