require 'rails_helper'

describe UserToken do
  it { should belong_to(:user) }
end
