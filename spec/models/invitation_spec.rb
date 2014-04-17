require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:recipient_email) }
  
end