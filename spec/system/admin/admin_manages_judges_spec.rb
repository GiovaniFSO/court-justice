require 'rails_helper'
require 'webdrivers'
describe 'Judge management' do
  before do
    driven_by :selenium, using: :chrome
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

  context 'new' do
    it 'successfully' do
      admin = create(:user, role: 'admin')

      visit root_path(as: admin)
      click_on 'New'
      fill_in 'Name', with: 'Jane'
      fill_in 'Username', with: 'janedoe'
      fill_in 'Email', with: 'jane@doe.com'
      fill_in 'Password', with: '123456'
      click_on 'Sign up'

      expect(page).to have_content('Jane')
      expect(page).to have_content('janedoe')
      expect(page).to have_content('jane@doe.com')
      expect(page).to have_content('Judge created successfully')
    end

    it 'attributes cannot be blank' do
      admin = create(:user, role: 'admin')

      visit root_path(as: admin)
      click_on 'New'
      fill_in 'Role', with: ''
      click_on 'Sign up'

      expect(page).to have_content("can't be blank", count: 5)
    end

    it 'email and username must to be unique' do
      admin = create(:user, role: 'admin')
      create(:user, username: 'janedoe', email: 'jane@doe.com', password: '123456', name: 'Jane Doe', role: 'judge')

      visit root_path(as: admin)
      click_on 'New'
      fill_in 'Username', with: 'janedoe'
      fill_in 'Email', with: 'jane@doe.com'
      fill_in 'Password', with: '123456'
      fill_in 'Name', with: 'Jane Doe'
      click_on 'Sign up'

      expect(page).to have_content('has already been taken', count: 2)
    end
  end
  it 'view judges' do
    admin = create(:user, email: 'admin@email.com', username: 'admin', name: 'Admin', role: 'admin')
    create(:user, email: 'jhon@doe.com', username: 'jhondoe', name: 'Jhon Doe', role: 'judge')
    create(:user, email: 'jane@doe.com', username: 'janedoe', name: 'Jane Doe', role: 'judge')

    visit root_path(as: admin)
    click_on 'Judges'

    expect(page).to have_content('jhondoe')
    expect(page).to have_content('jhon@doe.com')
    expect(page).to have_content('janedoe')
    expect(page).to have_content('jane@doe.com')
  end

  it 'no judge registered' do
    admin = create(:user, email: 'admin@email.com', username: 'admin', name: 'Admin', role: 'admin')

    visit root_path(as: admin)
    click_on 'Judges'

    expect(page).to have_content('No judge registered')
  end
end
