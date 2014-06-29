require 'rails_helper'

describe User do
  it { should have_many(:reviews) }
  it { should have_secure_password }
  it { should validate_presence_of :username }
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation}
  it { should ensure_length_of(:password).is_at_least(8)}
  it { should validate_uniqueness_of :email }
end
