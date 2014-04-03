require 'spec_helper'

feature 'User follows other users' do 
  scenario 'adds and deletes followers' do
    comedies = Fabricate(:category, name: 'Comedies')
    futurama = Fabricate(:video, title: 'Futurama', category: comedies)
    bob = Fabricate(:user)
    review = Fabricate(:review, rating: 4, video: futurama, user: bob)
    alice = Fabricate(:user)
    visit sign_in_path
    user_signs_in(alice)

    find("a[href='/videos/#{futurama.id}']").click
    expect(page).to have_content(futurama.title)
    expect(page).to have_content(bob.full_name)
    
    find("a[href='/users/#{bob.id}']").click
    click_link("Follow")

    visit users_path
    expect(page).to have_content(bob.full_name)
    find("a[href='/relationships/#{bob.id}']").click
    expect(page).to have_no_content(bob.full_name)
  end
end