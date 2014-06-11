class UserSignUp
  
  attr_reader :error_message
  
  def initialize(user)
    @user = user
  end
  
  def sign_up(stripe_token, invitation_token)
    if @user.valid?
      token = stripe_token
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      customer = StripeWrapper::Customer.create(
        :user => @user, 
        :card => token
      )
      #if user input is valid, check if the charge is successful
      if customer.successful?
        @user.customer_token = customer.customer_token
        @user.save
        handle_invitation(invitation_token)
        AppMailer.delay.send_welcome_email(@user)
        #session[:user_id] = @user.id
        @status = :success
        self
      else
        @status = :failed
        @error_message = customer.error_message
        self
      end
    else
      @status = :failed
      @error_message = "Your account could not be created."
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
      @user.follow(invitation.inviter) #where user invited to join by existing user and automatically follows existing user
      invitation.inviter.follow(@user) #where existing user follows the person invited
      invitation.update_column(:token, nil) #expires the token upon acceptance
    end
  end
end