require 'spec_helper'

describe ResetPasswordController do
  describe 'POST create' do
    it "creates an email instance variable" do
      email = Fabricate(:email)
    end
  end
end