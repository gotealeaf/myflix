require 'spec_helper'


feature 'user follows another user' do

  background do
    @hank = Fabricate(:user)
    @joe = Fabricate(:user)
  end

  scenario 'user follows another user' do
    sign_in(@hank)
    visit "users/#{@joe.id}"
    page.should have_content 'Follow'

    click_link('Follow')
    page.should have_content "People I Follow"


    visit "users/#{@joe.id}"
    page.should_not have_content 'Follow'

  end

end
