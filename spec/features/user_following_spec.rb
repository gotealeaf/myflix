require 'rails_helper'

feature 'People' do

  scenario 'user follows and unfollows another user' do
    genre = Fabricate(:genre)
    video = Fabricate(:video, genre: genre)
    other_user = Fabricate(:user)
    review = Fabricate(:review, video: video, user: other_user)

    user_signs_in(user)
    expect(page).to have_content("Welcome #{ user.username }")

    click_on(video.id)
    expect(page).to have_content(video.description)

    click_on(other_user.full_name)
    expect(page).to have_content("#{ other_user.full_name }'s video collections")

    click_on("Follow")
    expect(page).to have_content("#{ other_user.full_name }")

    click_on(other_user.full_name)
    expect(page).to have_content("#{ other_user.full_name.titleize }'s Reviews ( #{ other_user.count_reviews } )")

    click_on("People")
    unfollow(other_user)
    expect(page).to have_content("You are no longer following #{ other_user.full_name }")
  end

  def unfollow(user)
    find("a[href='/followings/#{ user.id }']").click
  end
end
