class UserSignup

  attr_reader :error_message
  
  def initialize(user)
    @user = user
  end

  def sign_up(stripe_token, invitation_token)
   if @user.valid?
      customer = StripeWrapper::Customer.create(
        :user => @user,
        :card => stripe_token
      )
      if customer.successful?
        @user.customer_token = customer.customer_token
        @user.save
        handle_invitation(invitation_token)
        AppMailer.send_welcome_email(@user).deliver
        @status = :success
        self
      else
        @status = :failed
        @error_message = customer.error_message
        self
      end
    else
      @status = :failed
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
      invitation = Invitation.where(token: invitation_token).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
end

