class AddRoleToGroupMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :group_members, :role, :integer, default: 1
  end
end
