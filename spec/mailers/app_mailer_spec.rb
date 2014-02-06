require 'spec_helper'

describe AppMailer do
  describe '#welcome_email' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    let(:user) { Fabricate(:user) }
    let!(:email) { AppMailer.welcome_email(user).deliver }

    it 'sends an email' do
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it 'sends the email to the proper user' do
      expect(email.to).to eq([user.email])
    end

    it 'sends the email from the proper address' do
      expect(email.from).to eq([ENV['SMTP_USER']])
    end

    it 'sets the correct subject' do
      expect(email.subject).to eq('Welcome to myflix')
    end

    it 'sets the correct body' do
      body_string = "Welcome to myflix, #{user.full_name}.\nWe are currently expanding our video library, so make sure you check out the library often!"
      expect(email.body.to_s).to include(body_string)
    end
  end
end
