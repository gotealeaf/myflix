class UserSignUp

  attr_reader :error_message, :user

  def initialize(user, charge_token, friendship_token)
    @user = user
    @charge_token = charge_token
    @friendship_token = friendship_token
  end

  def user_sign_up
    if @user.valid?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      customer = StripeWrapper::Customer.create(
        card: @charge_token,
        email: @user.email
      )
      if customer.successful?
        @user.save
        handle_friendship
        friend_full_name = @friend.user.full_name if @friend
        AppMailer.delay.send_welcome_email(@user, friend_full_name)
        @friend.update_column(:token, nil) if @friend
        @status = true 
      else
        @status = false
        @error_message = customer.error_message
      end
    else
      @status = false
      @error_message = "Please fix the errors below."
    end
    self
  end

  def successful?
    @status
  end

  private

  def handle_friendship
    @friend = Friend.where(token: @friendship_token).first if @friendship_token
    if @friend
      @user.leaders << @friend.user if @user.allow_to_follow?(@friend.user)
      @friend.user.leaders << @user if @friend.user.allow_to_follow?(@user)
    end
  end
end