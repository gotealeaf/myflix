class UserSignup
  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def sign_up(stripe_token,invitation_token)
    if @user.valid?
      token = stripe_token
      charge = StripeWrapper::Charge.create(
        :amount => 999, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "Sign Up Charge for #{@user.email}"
      )
      if charge.successful?
        @user.save
        handle_invitation(invitation_token)
        AppMailer.send_welcome_email(@user).deliver
        @status = :success
        self
      else
        @status = :fail
        @error_message = charge.error_message
        self
      end
    else
      @status = :fail
      @error_message = "Invalid user information. Please check the errors below."
      self
    end
  end

  def successful?
    @status == :success
  end

  private

  def handle_invitation(invitation_token)
    if invitation_token.present?
      invitation = Invitation.find_by(token: invitation_token)
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
end
