class InvitesController < ApplicationController

  def create
    event     = Event.find(params[:event_id])
    recipient = User.find_by_email(params[:email])
    if recipient
      event.invitations.create(recipient_id: recipient.id)
      flash[:notice] = "You have invited #{recipient.email}"
    else
      flash[:failuer] = "There is no user with email #{params[:email]}"
    end
    redirect_to(event)
  end

  def accept
    invitation = Invitation.find(params[:id])
    invitation.event.attendees << invitation.recipient
    flash[:notice] = "You are added to list of attendees of #{invitation.event.title}"
    user = User.find(invitation.recipient.id)
    invitation.destroy
    redirect_to(user)
  end

  def decline
    invitation = Invitation.find(params[:id])
    flash[:notice] = "You denied invitation for #{invitation.event.title}"
    user = User.find(invitation.recipient.id)
    invitation.destroy
    redirect_to(user)
  end
end
