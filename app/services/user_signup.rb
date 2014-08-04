class UserSignup

  attr_reader :error_message

  def initialize user
    @user = user
  end

  def sign_up stripe_token, invitation_token
    if @user.valid?

      charge = StripeWrapper::Charge.create(
        :amount      => 999,
        :currency    => "usd",
        :card        => stripe_token,
        :description => "Sign up charge for #{ @user.email }"
      )

      if charge.successful?
        @user.save
        create_invitation_relationships @user, invitation_token
        AppMailer.send_welcome_email(@user).deliver
        @status = :success
        self
      else
        @status = :failed
        @error_message = charge.error_message
        self
      end

    else
      @status = :failed
      @error_message = "User couldn't be created. . Please check the following errors. #{@user.errors.full_messages.first}"
      self
    end
  end

  def successful?
    @status == :success
  end

  private

  def create_invitation_relationships user, invitation_token
    invitation = Invitation.find_by_token(invitation_token)
    if invitation
      create_relationships invitation.inviter, user 
      invitation.update_column(:token, nil)
    end        
  end

  def create_relationships inviter_user, invited_user
    inviter_user.follow invited_user
    invited_user.follow inviter_user
  end  
end