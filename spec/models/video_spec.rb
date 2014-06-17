require 'rails_helper'

describe Video do
  it { should belong_to(:genre) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of :name }
end
