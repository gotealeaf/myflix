class UserSignup

  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def sign_up(stripeToken, invite_token)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
          amount: 999,
          card: stripeToken,
          description: "Sign up charge for #{ @user.email }"
        )
      if charge.successful?
        @user.save!
        MyflixMailer.delay.welcome_email(user.id)
        follow_inviter_if_invited(invite_token)
        delete_token_if_invited(invite_token)
        @status = :pass
        self
      else
        @status = :fail
        @error_message = charge.error_message
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
