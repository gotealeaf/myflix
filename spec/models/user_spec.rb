require 'rails_helper'

describe User do 
  it { should have_many(:my_queue_videos).order(:index)}
end