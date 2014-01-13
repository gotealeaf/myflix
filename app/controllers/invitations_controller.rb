  class InvitationsController < ApplicationController
      before_filter :require_user
      def new
        @invitation = Invitation.new
      end

      def create
        @invitation = Invitation.create(params[:invitation].merge!(inviter_id: current_user.id))
        if @invitation.save
        AppMailer.send_invitation_email(@invitation).deliver
        flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
        redirect_to new_invitation_path
      else
        flash[:error] = "Don't be an idiot and make sure everything is filled out correctly. Thanks!"
        render :new
      end
    end
  end