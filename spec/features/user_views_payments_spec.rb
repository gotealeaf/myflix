require 'rails_helper'

feature 'Use views pyaments' do

  given(:admin) { Fabricate(:user, admin: true) }
  background do
    nelle = Fabricate(:user, full_name: 'Nelle May')
    Fabricate(:payment, user: nelle, amount: 999, reference_id: "abcdefg")
  end

  scenario 'User is admin an views payments' do
    user_signs_in(admin)
    visit admin_payments_path
    expect(page).to have_content('Nelle May')
    expect(page).to have_content("$9.99")
    expect(page).to have_content("abcdefg")
  end
  scenario 'User is not admin and cannot view payments' do
    Fabricate(:genre, name: 'action')
    user_signs_in(user)
    visit admin_payments_path
    expect(page).not_to have_content('Nelle May')
    expect(page).to have_content('Action')
  end
end
