require 'rails_helper'

describe PasswordReset do
  it { should belong_to(:user) }
end
