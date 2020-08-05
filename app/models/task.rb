class Task < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :group, optional: true

  def assignee
    User.find(assigned_to) if assigned_to.present?
    nil
  end

  def completer
    User.find(completed_by) if completed_by.present?
    nil
  end
end
