class UserSignup

  attr_reader :error_message, :user

  def initialize(user)
    @user = user
  end

  def sign_up(stripeToken, invite_token)
    if @user.valid?
      set_stripe_sec_key
      customer = StripeWrapper::Customer.create(
          card: stripeToken,
          email: user.email
        )
      if customer.successful?
        @user.stripe_id = customer.stripe_id
        @user.save!
        MyflixMailer.delay.welcome_email(user.id)
        follow_inviter_if_invited(invite_token)
        delete_token_if_invited(invite_token)
        @status = :pass
        self
      else
        @status = :fail
        @error_message = customer.error_message
        self
      end
    else
      @status = :fail
      @error_message = "Incorrect registration inputs"
      self
    end
  end

  def successful?
    @status == :pass
  end

  private

  def set_stripe_sec_key
    if Rails.env.development? || Rails.env.test?
      Stripe.api_key = Rails.application.secrets.stripe_sec_key
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
  end

  def follow_inviter_if_invited(invite_token)
    unless invite_token.blank?
      inviter = UserToken.find_by(token: invite_token).user
      Following.create(user: @user, followee: inviter)
      Following.create(user: inviter, followee: @user)
    end
  end

  def delete_token_if_invited(invite_token)
    unless invite_token.blank?
      user_token = UserToken.find_by(token: invite_token)
      user_token.delete
    end
  end
end
