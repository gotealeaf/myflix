require 'spec-helper'
require 'pry'

describe 'POST #create' do
  context 'user signed in' do
    it 'sets the @review object correct'
    it 'saves valid input'
    it 'does not save valid input'
    it 'shows confirmation if save successful'
    it 'shows failure message if save fails'
    it 'renders videos#show page after save attempt'
  end
  context 'no user signed in' do
    it 'prevents the user from saving'
    it 'redirects the user to the home page'
    it 'flashes correct message to user'
  end
end
