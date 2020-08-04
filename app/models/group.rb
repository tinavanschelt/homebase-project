class Group < ApplicationRecord
  has_many :group_members
  has_many :users, through: :group_members
  has_many :invitations

  enum group_type: [:family]

  def admin?(user)
    member = group_members.where(user_id: user.id).first
    return false if member.blank?
    return true if member.admin?
    false
  end

  def add_admin(user)
    group_members.create(user_id: user.id, role: 0)
  end

  def add_member(user)
    group_members.create(user_id: user.id)
  end
end
