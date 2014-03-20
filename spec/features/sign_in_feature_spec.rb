feature "login, add videos to queue and check queue works correctly" do

  given(:video1) { Fabricate(:video) }
  given(:video2) { Fabricate(:video) }
  given(:video3) { Fabricate(:video) }
  given(:adam) { Fabricate(:user) }

  scenario "user signing in with valid credentials" do
    visit login_path
    fill_in "Email", :with => adam.email
    fill_in "Password", :with => adam.password
    click_button "Submit"
    expect(page).to have_content "You are now logged in."
  end

  scenario "select video and go to video show page" do
    visit home_path
    find('div#video_3.video.col-sm-2').click
    expect(page).to have_content "Family Guy"
  end
end
