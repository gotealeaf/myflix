require 'rails_helper'

describe Video do
  it { should belongs_to(:category) }
  it { should validates_presence_of(:title) }
  it { should validates_presence_of(:description) }
end