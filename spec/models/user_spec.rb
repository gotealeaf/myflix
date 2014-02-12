require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe User do
  it { should have_secure_password}
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
