  class InvitationsController < ApplicationController
      before_action :require_user
      def new
        @invitation = Invitation.new
      end

      def create
        @invitation = Invitation.new(invitation_params)
        @invitation.inviter_id = current_user.id
        if @invitation.save
        AppMailer.delay.send_invitation_email(@invitation)
        flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
        redirect_to new_invitation_path
      else
        flash[:error] = "Don't be an idiot and make sure everything is filled out correctly. Thanks!"
        render :new
      end
    end

    private

    def invitation_params
      params.require(:invitation).permit(:inviter_id, :recipient_name, :recipient_email, :message)
    end
  end