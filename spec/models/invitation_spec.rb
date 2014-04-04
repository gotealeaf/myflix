require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe Invitation do

  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:status) }
end
