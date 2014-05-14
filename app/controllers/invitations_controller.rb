class InvitationsController < AuthenticatedController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.
                                  merge!(inviter_id: current_user.id))
    if @invitation.save
      InvitationMailer.delay.email_invitation(@invitation.id)
      flash[:success] = ("Your invitation has been emailed to 
                          #{@invitation.recipient_name}")
      redirect_to new_invitation_path
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :recipient_name, 
                                       :message)
  end
end