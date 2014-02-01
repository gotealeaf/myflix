require 'spec_helper'

feature 'User signs in' do

  scenario "with existing email address" do
    sign_in
  end
end