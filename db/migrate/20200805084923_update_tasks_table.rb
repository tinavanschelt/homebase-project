class UpdateTasksTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :user_id, :user_id
    add_column :tasks, :group_id, :integer
  end
end
