class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :scope => [:group_id]

  scope :unaccepted, -> { where(accepted: false) }

  def accept
    update_attribute(:accepted, true)
  end
end
