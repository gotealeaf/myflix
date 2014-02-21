require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe Review do
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }
end
