class InvitationMailer < ApplicationMailer
  def invite_member(invite)
    puts "SENDING INVTE #{invite.inspect}"
    @invite = invite
    mail(to: @invite.email, subject: "You've been invited to join #{@invite.group.title} on Homebase!")
  end
end
