require 'rails_helper'

describe User do
  it { should validate_presence_of (:name) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  it { should validate_uniqueness_of (:email) }
  it { should have_secure_password }
  it { should have_many(:queue_items).order(:position) }
end