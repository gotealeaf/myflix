require 'rails_helper'

describe UserSignup do

  describe '#sign_up' do
    context 'if personal info and credit card are valid' do

      let(:customer) { double('customer', successful?: true, stripe_id: "asdefg") }

      before do
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
      end

      it 'creates a new user' do
        UserSignup.new(Fabricate.build(:user)).sign_up("stripeToken", nil)
        expect(User.count).to eq(1)
      end

      it 'stores the stripe customer id' do
        UserSignup.new(Fabricate.build(:user)).sign_up("stripeToken", nil)
        expect(User.first.stripe_id).to eq("asdefg")
      end
      it 'delivers a welcome email' do
        UserSignup.new(Fabricate.build(:user)).sign_up("stripeToken", nil)
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it 'delivers to the correct recipient' do
        UserSignup.new(Fabricate.build(:user, username:'test_user', full_name: 'test_user',
                              email: 'user@example.com', password: 'password',
                              password_confirmation: 'password')).sign_up("stripeToken", nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['user@example.com'])
      end
      it 'has the correct content' do
        UserSignup.new(Fabricate.build(:user, username:'test_user', full_name: 'test_user',
                                                    email: 'user@example.com', password: 'password',
                                                    password_confirmation: 'password')).sign_up("stripeToken", nil)
        expect(ActionMailer::Base.deliveries.last.body).to include('Welcome to MyFlix')
      end
    end

      context 'if user was invited to register' do

        let(:customer) { double('customer', successful?: true, stripe_id: 'abcdefg') }

        before do
          allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
        end

        it 'should delete the token after registration' do
          invite_token = Fabricate(:user_token)
          UserSignup.new(Fabricate(:user)).sign_up(nil, invite_token.token)
          expect(UserToken.count).to eq(0)
        end
        it 'should create a new following for new user to inviter if invited' do
          inviter = Fabricate(:user)
          invite_token = Fabricate(:user_token, user: inviter)
          UserSignup.new(Fabricate(:user)).sign_up(nil, invite_token.token)
          new_user = User.where.not(id: inviter.id).first
          expect(new_user.followings.first.followee).to eq(inviter)
        end
        it 'should create a new following for inviter to new user if invited' do
          inviter = Fabricate(:user)
          invite_token = Fabricate(:user_token, user: inviter)
          UserSignup.new(Fabricate(:user)).sign_up(nil, invite_token.token)
          new_user = User.where.not(id: inviter.id).first
          expect(inviter.followings.first.followee).to eq(new_user)
        end
      end

    context 'if personal info valid but credit card invalid' do

      let(:customer) { double('charge', successful?: false, error_message: 'Check error') }

      before do
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
      end

      it 'does not create a new user' do
        UserSignup.new(Fabricate.build(:user)).sign_up('stripeToken', nil)
        expect(User.count).to eq(0)
      end
    end

    context 'if validation fails' do
      it 'does not create a user' do
        UserSignup.new(Fabricate.build(:user, username: '')).sign_up(nil, nil)
        expect(User.count).to eq(0)
      end
      it 'does not charge the users credit card' do
        expect(StripeWrapper).not_to receive(:create)
        UserSignup.new(Fabricate.build(:user, username: '')).sign_up(nil, nil)
      end
    end
  end
end
