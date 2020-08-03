class InvitationMailer < ApplicationMailer
  def invite_member(invite)
    @invite = invite
    @group = invite.group
    mail(to: @invite.email, subject: "You've been invited to join #{@group.title} on Homebase!")
  end
end
