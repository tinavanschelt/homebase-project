class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum role: [:admin, :member]

  def admin?
    role == "admin"
  end
end
