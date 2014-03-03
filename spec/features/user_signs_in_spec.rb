require 'spec_helper'

feature 'User signs in' do

  scenario "with valid email and password" do
    sign_in
  end
end