class Group < ApplicationRecord
  has_many :group_members
  has_many :users, through: :group_members
  has_many :invitations

  enum group_type: [:family]
end
