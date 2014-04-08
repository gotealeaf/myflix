require 'spec_helper'

feature "Admin sees payments" do
  background do
    desmond = Fabricate(:user, fullname: 'Desmond', email: 'desmond@123.com')
    Fabricate(:payment, amount: 999, user: desmond)
  end
  scenario 'admin can see payments' do
    sign_in(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Desmond")
    expect(page).to have_content("desmond@123.com")
  end
  scenario 'user can not see payments' do
    sign_in(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Desmond")
    expect(page).not_to have_content("desmond@123.com")
    expect(page).to have_content("You don't have authority to do that!")
  end
end
