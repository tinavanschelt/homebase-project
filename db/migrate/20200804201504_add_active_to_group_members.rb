class AddActiveToGroupMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :group_members, :active, :boolean, default: false
  end
end
