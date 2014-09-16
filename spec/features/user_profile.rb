require 'spec_helper'


feature 'user profile' do
  background do
    @hank = Fabricate(:user)
    @mystery = Fabricate(:category)
    @monk = Fabricate(:video, category: @mystery)
    @conk = Fabricate(:video, category: @mystery)
    @qi = Fabricate(:queue_item, video: @monk, user: @hank)
    @qi = Fabricate(:queue_item, video: @conk, user: @hank)
  end

  scenario 'user reorders videos in queue' do
    sign_in
    visit 'users/1'
    page.should have_content @hank.queue_items.count.to_s

  end

end
