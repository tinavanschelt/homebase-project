# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def invite_member_preview
    @invite = Invite.first
    mail(to: @invite.email, subject: "You've been invited to join #{@invite.group.title} on Homebase!")
  end
end
