require 'rails_helper'

describe Genre do
  it { should have_many(:videos).order(:name) }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name}
end
