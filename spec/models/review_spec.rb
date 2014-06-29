require 'rails_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of :rating }
  it { should validate_presence_of :review }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :video_id }
end
