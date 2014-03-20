feature "Signing In" do

  background do
    Fabricate(:user, email: "matthew@gmail.com", password: "test" )
  end

  scenario "user signing in with valid credentials" do
    visit login_path
    fill_in "Email", :with => "matthew@gmail.com"
    fill_in "Password", :with => "test"
    click_button "Submit"
    expect(page).to have_content "You are now logged in."
  end
end
